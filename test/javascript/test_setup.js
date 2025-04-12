import { Application } from '@hotwired/stimulus';

// Setup global variables that would be available in the browser
global.MutationObserver = class {
  constructor(callback) {}
  disconnect() {}
  observe(element, initObject) {}
};

// Mock for Rails UJS
global.Rails = {
  ujs: {
    assert: {
      ok: expect.extend({
        toBeOk(received, message) {
          const pass = Boolean(received);
          return {
            pass,
            message: () => message || `Expected ${received} to be truthy`
          };
        }
      }),
      equal: (actual, expected, message) => {
        expect(actual).toBe(expected);
      }
    }
  }
};

// Setup for stimulus controllers
window.Stimulus = Application.start();

// Add the describe/test/etc functions to the global scope
global.describe = describe;
global.test = test;
global.it = test;
global.expect = expect;
global.beforeEach = beforeEach;
global.afterEach = afterEach;