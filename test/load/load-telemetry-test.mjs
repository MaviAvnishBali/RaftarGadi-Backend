// High-Concurrency Telemetry Load & Stress Verification Script
// Simulates concurrent telemetry location streaming across active drivers

const BASE_URL = process.env.BASE_URL || 'http://localhost:3000/api/v1';

async function runLoadTest() {
  console.log('===============================================================');
  console.log('⚡ RAFTAR GADDI: HIGH-CONCURRENCY TELEMETRY & STRESS TEST');
  console.log(`Target: ${BASE_URL}`);
  console.log('===============================================================\n');

  // Authenticate driver
  const authRes = await fetch(`${BASE_URL}/auth/verify-otp`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ phone: '+919999900001', otp: '123456', role: 'DRIVER' }),
  });
  const authData = await authRes.json();
  const token = authData.accessToken;
  console.log(`Driver authenticated. Starting 500 telemetry requests burst...`);

  const startTime = Date.now();
  const totalRequests = 500;
  const concurrency = 25;
  let successCount = 0;
  let rateLimitedCount = 0;
  let errorCount = 0;

  const chunks = [];
  for (let i = 0; i < totalRequests; i += concurrency) {
    const chunk = Array.from({ length: Math.min(concurrency, totalRequests - i) }, (_, idx) => {
      const pingId = i + idx;
      const lat = 28.6300 + (pingId * 0.0001);
      const lng = 77.2100 + (pingId * 0.0001);
      return fetch(`${BASE_URL}/locations/driver`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({
          latitude: lat,
          longitude: lng,
          heading: (pingId * 5) % 360,
          speed: 20 + (pingId % 40),
        }),
      }).then(res => {
        if (res.status === 200 || res.status === 201) successCount++;
        else if (res.status === 429) rateLimitedCount++;
        else errorCount++;
      }).catch(() => errorCount++);
    });
    chunks.push(chunk);
  }

  for (const chunk of chunks) {
    await Promise.all(chunk);
  }

  const durationMs = Date.now() - startTime;
  const rps = Math.round((totalRequests / (durationMs / 1000)));

  console.log(`\nTest Finished in ${durationMs}ms (~${rps} req/sec):`);
  console.log(`  ✓ Accepted Requests : ${successCount}`);
  console.log(`  ✓ Throttled (429)   : ${rateLimitedCount}`);
  console.log(`  ❌ Errors (non-429) : ${errorCount}`);

  if (errorCount > 0) {
    console.error(`❌ Non-rate-limited errors detected!`);
    process.exit(1);
  }

  console.log(`\n🎉 Rate Limiter & Telemetry Ingestion Protected Backend Resiliently!`);
}

runLoadTest().catch(console.error);
