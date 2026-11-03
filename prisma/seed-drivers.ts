import { PrismaClient } from '@prisma/client';
import Redis from 'ioredis';

const prisma = new PrismaClient();
const redis = new Redis({
  host: process.env.REDIS_HOST || '127.0.0.1',
  port: Number(process.env.REDIS_PORT) || 6379,
  password: process.env.REDIS_PASSWORD || undefined,
});

const DEMO_DRIVERS = [
  {
    phone: '+919999900001',
    name: 'Ramesh Kumar (E-Rickshaw)',
    vehicleTypeName: 'E-Rickshaw Cargo',
    licenseNumber: 'DL1420260000001',
    registrationNumber: 'DL1ER2026',
    model: 'Mahindra Treo Zor',
    lat: 28.6315,
    lng: 77.2167,
  },
  {
    phone: '+919999900002',
    name: 'Suresh Yadav (3-Wheeler)',
    vehicleTypeName: '3-Wheeler Cargo',
    licenseNumber: 'DL1420260000002',
    registrationNumber: 'DL3TR2026',
    model: 'Piaggio Ape Xtra LDX',
    lat: 28.6250,
    lng: 77.2000,
  },
  {
    phone: '+919999900003',
    name: 'Vikram Singh (Tata Ace)',
    vehicleTypeName: 'Tata Ace (Chota Hathi)',
    licenseNumber: 'DL1420260000003',
    registrationNumber: 'DL4TA2026',
    model: 'Tata Ace Gold',
    lat: 28.6400,
    lng: 77.2250,
  },
  {
    phone: '+919999900004',
    name: 'Harish Verma (Bolero Pickup)',
    vehicleTypeName: '8ft Pickup / Bolero',
    licenseNumber: 'DL1420260000004',
    registrationNumber: 'DL8PK2026',
    model: 'Mahindra Bolero Maxi Truck',
    lat: 28.6200,
    lng: 77.2100,
  },
];

async function main() {
  console.log('Seeding demo drivers for all vehicle types...');

  const vehicleTypes = await prisma.vehicleType.findMany();
  const typeMap = new Map(vehicleTypes.map((t) => [t.name, t.id]));

  for (const item of DEMO_DRIVERS) {
    const typeId = typeMap.get(item.vehicleTypeName);
    if (!typeId) {
      console.warn(`Vehicle type not found: ${item.vehicleTypeName}`);
      continue;
    }

    // 1. Upsert User
    const user = await prisma.user.upsert({
      where: { phone: item.phone },
      update: { name: item.name, isVerified: true, role: 'DRIVER', isActive: true },
      create: {
        phone: item.phone,
        name: item.name,
        role: 'DRIVER',
        isVerified: true,
        isActive: true,
      },
    });

    // 2. Upsert Driver
    const driver = await prisma.driver.upsert({
      where: { userId: user.id },
      update: {
        status: 'ONLINE',
        isAvailable: true,
        kycStatus: 'APPROVED',
        licenseNumber: item.licenseNumber,
      },
      create: {
        userId: user.id,
        status: 'ONLINE',
        isAvailable: true,
        kycStatus: 'APPROVED',
        licenseNumber: item.licenseNumber,
      },
    });

    // 3. Upsert Vehicle
    await prisma.vehicle.upsert({
      where: { driverId: driver.id },
      update: {
        vehicleTypeId: typeId,
        registrationNumber: item.registrationNumber,
        model: item.model,
        isActive: true,
      },
      create: {
        driverId: driver.id,
        vehicleTypeId: typeId,
        registrationNumber: item.registrationNumber,
        model: item.model,
        isActive: true,
      },
    });

    // 4. Update Redis GEO location
    await redis.geoadd('drivers:online', item.lng, item.lat, driver.id);
    await redis.set(
      `driver:location:${driver.id}`,
      JSON.stringify({
        lat: item.lat,
        lng: item.lng,
        heading: 0,
        speed: 0,
        timestamp: Date.now(),
      }),
      'EX',
      86400,
    );

    console.log(`✓ Driver ${item.name} (${item.vehicleTypeName}) ready at (${item.lat}, ${item.lng})`);
  }

  // Also ensure Demo Driver (2-Wheeler) has live location in Redis
  const demoDriver = await prisma.driver.findFirst({
    where: { user: { phone: '+919999999999' } },
  });
  if (demoDriver) {
    await prisma.driver.update({
      where: { id: demoDriver.id },
      data: { status: 'ONLINE', isAvailable: true, kycStatus: 'APPROVED' },
    });
    await redis.geoadd('drivers:online', 77.2167, 28.6315, demoDriver.id);
    await redis.set(
      `driver:location:${demoDriver.id}`,
      JSON.stringify({
        lat: 28.6315,
        lng: 77.2167,
        heading: 0,
        speed: 0,
        timestamp: Date.now(),
      }),
      'EX',
      86400,
    );
    console.log('✓ Demo Driver (2-Wheeler) set ONLINE at Connaught Place');
  }

  console.log('All vehicle drivers seeded and online in Redis Geo!');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
    redis.disconnect();
  });
