path = require 'path'

module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)

  config =
    rpmName: 'mydoglacy-api'
    rpmVersion: '0'
    dist: 'dist'

  grunt.initConfig
    config: config

    clean: [
      'rpms'
    ]

    copy:
      dist:
        expand: true
        cwd: 'node_modules'
        src: '**'
        dest: '<%= config.dist %>/node_modules'

    easy_rpm:
      options:
        name: "<%= config.rpmName %>"
        version: "<%= config.rpmVersion %>"
        release: 1
        buildArch: "noarch"
        defaultAttributes:
          mode: 755
          dirMode: 755
          user: 'mydoglacy'
          group: 'mydoglacy'
        preInstallScript: ['exit 0']
        postInstallScript: [
          'systemctl daemon-reload'
          'systemctl enable <%= config.rpmName %>.service'
          'systemctl stop <%= config.rpmName %>.service'
          'systemctl start <%= config.rpmName %>.service'
        ]
        preUninstallScript: ['exit 0']
        tempDir: 'tmp'
        rpmDestination: 'rpms'

      release:
        files: [
          cwd: '<%= config.dist %>'
          src: '**/*'
          dest: "/home/mydoglacy/<%= config.rpmName %>"
          user: 'mydoglacy'
          group: 'mydoglacy'
        ,
          cwd: 'resources/systemd/'
          src: '*'
          dest: '/etc/systemd/system/'
          user: 'root'
          group: 'root'
        ,
          cwd: "templates"
          src: 'app.log'
          dest: '/var/log/<%= config.rpmName %>'
          user: 'mydoglacy'
          group: 'mydoglacy'
        ,
          cwd: "templates"
          src: 'error.log'
          dest: '/var/log/<%= config.rpmName %>'
          user: 'mydoglacy'
          group: 'mydoglacy'
        ]

  grunt.registerTask "distribute", ->
    if not grunt.option('build')?
      grunt.fail.fatal 'must supply --build=BUILD_NUMBER'
    else
      build = grunt.option('build')
      config.rpmVersion = build
      grunt.task.run 'clean'
      grunt.task.run 'copy:dist'
      grunt.task.run 'easy_rpm'


  return
