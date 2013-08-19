
module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    coffee:
      compile:
        options:
          bare: true
        files:
          'lib/<%= pkg.name %>.js': 'src/<%= pkg.name %>.coffee'

    watch:
      scripts:
        files: 'src/*.coffee'
        tasks: ['coffee']

    clean: [
      'lib'
    ]

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.registerTask 'build', [
    'clean'
    'coffee'
  ]

  grunt.registerTask 'default', [
    'watch'
  ]
