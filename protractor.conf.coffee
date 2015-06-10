
exports.config =

  directConnect: true
  capabilities:
    'browserName': 'chrome'
  framework: 'jasmine2'
  specs: [ './tests/**/*.coffee' ]
  allScriptsTimeout: 500000
  jasmineNodeOpts:
    defaultTimeoutInterval: 500000
    print: -> # remove dot reporter

  onPrepare: ->
    specReporter = require 'jasmine-spec-reporter'
    reporter = new specReporter()
    jasmine.getEnv().addReporter(reporter)


