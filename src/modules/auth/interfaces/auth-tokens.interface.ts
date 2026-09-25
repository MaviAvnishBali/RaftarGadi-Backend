export interface AuthTokens {
  accessToken: string;
  refreshToken: string;
  expiresIn: number;
  user: {
    id: string;
    phone: string;
    role: string;
    fullName: string;
    isPhoneVerified: boolean;
  };
}
