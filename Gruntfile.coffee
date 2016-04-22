fs = require 'fs'
path = require 'path'

module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)

  config =
    rpmName: 'mydoglacy-ui'
    rpmVersion: '0'
    dist: 'dist'

  grunt.initConfig
    config: config

    clean: [
      'rpms'
    ]

    easy_rpm:
      options:
        name: "<%= config.rpmName %>"
        version: "<%= config.rpmVersion %>"
        release: 1
        buildArch: "noarch"
        defaultAttributes:
          mode: 755
          dirMode: 755
          user: 'node'
          group: 'node'
        preInstallScript: ['exit 0']
        postInstallScript: ['exit 0']
        preUninstallScript: ['exit 0']
        tempDir: 'tmp'
        rpmDestination: 'rpms'

      release:
        files: [
          cwd: '<%= config.dist %>'
          src: '**/*'
          dest: "/var/www/html/<%= config.rpmName %>"
          user: 'root'
          group: 'root'
        ]

  grunt.registerTask "distribute", ->
    if not grunt.option('build')?
      grunt.fail.fatal 'must supply --build=BUILD_NUMBER'
    else
      build = grunt.option('build')
      config.rpmVersion = build
      grunt.task.run [
        'clean'
        'easy_rpm'
      ]

  return
