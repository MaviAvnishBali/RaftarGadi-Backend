import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();
async function main() {
  await prisma.vehicleType.createMany({
    data: [
      { name: 'Bike', maxWeightKg: 20 },
      { name: 'Tata Ace', maxWeightKg: 750 },
      { name: 'Pickup Truck', maxWeightKg: 1500 }
    ],
    skipDuplicates: true,
  });
  console.log('Seeded vehicle types');
}
main().catch(console.error).finally(() => prisma.$disconnect());
