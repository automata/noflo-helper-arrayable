module.exports = ->
  # Project configuration
  @initConfig
    pkg: @file.readJSON 'package.json'

    # CoffeeScript compilation
    coffee:
      libraries:
        expand: true
        cwd: 'src/lib'
        src: ['**.coffee']
        dest: 'lib'
        ext: '.js'

    # Coding standards
    coffeelint:
      libraries:
        files:
          src: ['src/lib/*.coffee']
        options:
          max_line_length:
            value: 80
            level: 'warn'
          no_trailing_semicolons:
            level: 'warn'

  # Grunt plugins used for building
  @loadNpmTasks 'grunt-contrib-coffee'

  # Grunt plugins used for testing
  @loadNpmTasks 'grunt-coffeelint'

  # Our local tasks
  @registerTask 'build', 'Build noflo-helper-arrayable for the target platform', (target = 'all') =>
    @task.run 'coffee'

  @registerTask 'test', 'Build noflo-helper-arrayable and run automated tests', (target = 'all') =>
    @task.run 'coffeelint'
    @task.run 'coffee'

  @registerTask 'default', ['test']