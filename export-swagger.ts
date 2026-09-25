import { NestFactory } from '@nestjs/core';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { AppModule } from './src/app.module';
import * as fs from 'fs';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, { logger: false });
  
  const config = new DocumentBuilder()
    .setTitle('RaftarGadi API')
    .setDescription('The complete RaftarGadi logistics API documentation')
    .setVersion('1.0')
    .addBearerAuth(
      { type: 'http', scheme: 'bearer', bearerFormat: 'JWT' },
      'access-token',
    )
    .build();
    
  const document = SwaggerModule.createDocument(app, config);
  
  fs.writeFileSync('./raftargadi-api.json', JSON.stringify(document, null, 2));
  
  console.log('Successfully generated OpenAPI/Postman specification at ./raftargadi-api.json');
  await app.close();
}

bootstrap();
