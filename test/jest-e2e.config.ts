import type { Config } from 'jest';

const config: Config = {
  moduleFileExtensions: ['js', 'json', 'ts'],
  rootDir: '../src',
  testRegex: '.*\\.e2e\\.spec\\.ts$',
  transform: {
    '^.+\\.(t|j)s$': 'ts-jest',
  },
  testEnvironment: 'node',
  moduleNameMapper: {
    '^@common/(.*)$': '<rootDir>/common/$1',
    '^@config/(.*)$': '<rootDir>/config/$1',
    '^@database/(.*)$': '<rootDir>/database/$1',
    '^@modules/(.*)$': '<rootDir>/modules/$1',
    '^@jobs/(.*)$': '<rootDir>/jobs/$1',
  },
};

export default config;
