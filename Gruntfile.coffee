module.exports = (grunt) ->
  'use strict'

  # Load all grunt packages
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  grunt.initConfig
    coffee:
      options:
        bare: yes
      all:
        files:
          'dest/w-cart.js': 'src/w-cart.coffee'

    coffeelint:
      options:
        configFile: 'coffeelint.json'
      all:
        files:
          src: [
            'src/**/*.coffee'
          ]

    watch:
      options:
        interrupt: no
      all:
        files: [
          'Gruntfile.coffee'
          'src/**/*.coffee'
        ]
        tasks: [
          'coffeelint:all'
          'coffee:all'
        ]

    grunt.registerTask 'default', [
      'coffeelint:all'
      'coffee:all'
      'watch:all'
    ]
