import { Injectable, Logger } from '@nestjs/common';

@Injectable()
export class FcmService {
  private readonly logger = new Logger(FcmService.name);

  async sendPush(fcmToken: string, title: string, body: string, data?: object): Promise<boolean> {
    this.logger.log(`[MOCK FCM] Sending push to ${fcmToken}: ${title} - ${body}`);
    if (data) {
      this.logger.log(`[MOCK FCM] Data payload: ${JSON.stringify(data)}`);
    }
    // Simulate API call
    return true;
  }
}
