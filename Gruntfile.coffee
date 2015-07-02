module.exports = ( grunt ) ->
  pkg = grunt.file.readJSON "package.json"
  info =
    name: pkg.name.charAt(0).toUpperCase() + pkg.name.substring(1)
    version: pkg.version
  npmTasks = [
      "grunt-contrib-compass"
      "grunt-contrib-cssmin"
      "grunt-contrib-concat"
    ]

  grunt.initConfig
    repo: info
    pkg: pkg
    concat:
      sass:
        files:
          "_<%= pkg.name %>.scss": [
              "src/_sandwich.scss"
              "src/_frameset.scss"
            ]
    compass:
      compile:
        options:
          sassDir: "build"
          cssDir: "."
    cssmin:
      minify:
        options:
          banner: "/*!\n" +
                  " * <%= repo.name %> UI Library v<%= repo.version %>\n" +
                  " * <%= pkg.homepage %>\n" +
                  " *\n" +
                  " * Copyright 2015, <%= grunt.template.today('yyyy') %> Ourairyu, http://ourai.ws/\n" +
                  " *\n" +
                  " * Date: <%= grunt.template.today('yyyy-mm-dd') %>\n" +
                  " */\n"
          keepSpecialComments: 0
        files:
          "<%= pkg.name %>.min.css": "<%= pkg.name %>.css"

  grunt.loadNpmTasks task for task in npmTasks

  # Tasks about Sass
  grunt.registerTask "compile_sass", [
      "compass:compile"
      "cssmin"
    ]
  # Default task
  grunt.registerTask "default", [
      "concat:sass"
      "compile_sass"
    ]
