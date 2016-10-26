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
              "src/_variables.scss"
              # Utilities
              "src/utils/_box-model.scss"
              "src/utils/_boxes.scss"
              # Layouts
              "src/layouts/_sandwich.scss"
              "src/layouts/_frameset.scss"
              "src/layouts/_scroll.scss"
              # Rules
              "src/_boxes.scss"
            ]
      test:
        files:
          "test/stylesheets/_<%= pkg.name %>.scss": "_<%= pkg.name %>.scss"
    compass:
      options:
        outputStyle: "expanded"
        noLineComments: true
      compile:
        options:
          sassDir: "build"
          cssDir: "."
      test:
        options:
          sassDir: "test/stylesheets"
          cssDir: "test/stylesheets"
    cssmin:
      minify:
        options:
          banner: "/*!\n" +
                  " * <%= repo.name %> v<%= repo.version %>\n" +
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

  grunt.registerTask "compile_test", [
      "concat:test"
      "compass:test"
    ]

  # Default task
  grunt.registerTask "default", [
      "concat:sass"
      "compile_sass"
      "compile_test"
    ]
