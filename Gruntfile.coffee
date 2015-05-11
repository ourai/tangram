module.exports = ( grunt ) ->
  pkg = grunt.file.readJSON "package.json"
  info =
    name: pkg.name.charAt(0).toUpperCase() + pkg.name.substring(1)
    version: pkg.version
  npmTasks = [
      "grunt-contrib-compass"
      "grunt-contrib-cssmin"
      "grunt-contrib-concat"
      "grunt-contrib-copy"
    ]

  grunt.initConfig
    repo: info
    pkg: pkg
    meta:
      temp: ".<%= pkg.name %>-cache"
      image: "src/images"

      dest: "dest"
      dest_style: "<%= meta.dest %>/stylesheets"
      dest_image: "<%= meta.dest %>/images"

      tests: "test"
    concat:
      sass:
        files:
          "dest/stylesheets/<%= pkg.name %>.scss": [
              "src/stylesheets/_mixins.scss"
            ]
      matcha_helper:
        files:
          "test/stylesheets/_variables.scss": [
              "src/stylesheets/_variables.scss"
            ]
          "test/stylesheets/_functions.scss": [
              "src/stylesheets/_functions.scss"
            ]
          "test/stylesheets/_mixins.scss": [
              "src/stylesheets/mixins/_enhancement.scss"
              "src/stylesheets/mixins/_typography.scss"
              "src/stylesheets/mixins/_utilities.scss"
              "src/stylesheets/mixins/_components.scss"
              "src/stylesheets/mixins/_sandwich.scss"
              "src/stylesheets/mixins/_frameset.scss"
              "src/stylesheets/mixins/_internal.scss"
            ]
    compass:
      compile:
        options:
          sassDir: "build"
          cssDir: "<%= meta.dest_style %>"
          imagesDir: "<%= meta.dest_image %>"
      matcha_for_test:
        options:
          sassDir: "build"
          cssDir: "<%= meta.tests %>/stylesheets"
          imagesDir: "<%= meta.tests %>/images"
      test:
        options:
          sassDir: "<%= meta.tests %>"
          cssDir: "<%= meta.tests %>"
    copy:
      image:
        expand: true
        cwd: "<%= meta.image %>"
        src: ["**"]
        dest: "<%= meta.dest_image %>"
      test:
        expand: true
        cwd: "<%= meta.dest %>"
        src: ["images/*"]
        dest: "<%= meta.tests %>"
    cssmin:
      minify:
        options:
          banner: "/*!\n" +
                  " * <%= repo.name %> UI Library v<%= repo.version %>\n" +
                  " * <%= pkg.homepage %>\n" +
                  " *\n" +
                  " * Includes Normalize.css\n" +
                  " * http://necolas.github.io/normalize.css/\n" +
                  " *\n" +
                  " * Copyright 2013, <%= grunt.template.today('yyyy') %> Ourairyu, http://ourai.ws/\n" +
                  " *\n" +
                  " * Date: <%= grunt.template.today('yyyy-mm-dd') %>\n" +
                  " */\n"
          keepSpecialComments: 0
        files:
          "<%= meta.dest_style %>/<%= pkg.name %>.min.css": "<%= meta.dest_style %>/<%= pkg.name %>.css"

  grunt.loadNpmTasks task for task in npmTasks

  # Tasks about Sass
  grunt.registerTask "compile_sass", [
      "compass:compile"
      "cssmin"
    ]
  grunt.registerTask "test", [
      "copy:test"
      "compass:matcha_for_test"
      "concat:matcha_helper"
      "compass:test"
    ]
  # Default task
  grunt.registerTask "default", [
      # "compile_sass"
      "copy:image"
      "concat:sass"
      "test"
    ]
