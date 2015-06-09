module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-protractor-runner'

  grunt.initConfig

    protractor:

      options:
        configFile: './protractor.conf.coffee'
        keepAlive: true
        noColor: false
        args: {}
      target: {}

  grunt.registerTask 'default', [ 'protractor' ]
