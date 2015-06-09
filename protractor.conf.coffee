
exports.config =

  directConnect: true
  capabilities:
    'browserName': 'chrome'
  framework: 'jasmine2'
  specs: [ './tests/**/*.coffee' ]
  jasmineNodeOpts:
    defaultTimeoutInterval: 500000

