module.exports = {
  testEnvironment: 'jsdom',
  roots: ['<rootDir>/app/javascript/', '<rootDir>/test/javascript/'],
  moduleDirectories: ['node_modules', '<rootDir>/app/javascript'],
  moduleNameMapper: {
    '^@hotwired/stimulus$': '<rootDir>/node_modules/@hotwired/stimulus',
    '^controllers/(.*)$': '<rootDir>/app/javascript/controllers/$1'
  },
  transform: {
    '^.+\\.(js|jsx)$': 'babel-jest'
  },
  setupFilesAfterEnv: ['<rootDir>/test/javascript/test_setup.js'],
  testMatch: [
    "**/__tests__/**/*.[jt]s?(x)", 
    "**/?(*.)+(spec|test).[jt]s?(x)",
    "**/test/javascript/**/*_test.js"  // Add this pattern to match our file
  ]
};