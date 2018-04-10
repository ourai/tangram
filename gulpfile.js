"use strict";

const gulp = require("gulp");
const concat = require("gulp-concat");
const sass = require("gulp-sass");
const cssmin = require("gulp-cssmin");
const rename = require("gulp-rename");
const copy = require("gulp-copy");

gulp.task("concat", function() {
  gulp
    .src([
      "./src/components/_boxes.scss",
      "./src/layouts/_sandwich.scss",
      "./src/layouts/_frameset.scss",
      "./src/layouts/_scroll.scss"
    ])
    .pipe(concat("_tangram.scss"))
    .pipe(gulp.dest("./"));
});

gulp.task("compile", function() {
  gulp
    .src("src/**/*.scss")
    .pipe(sass({outputStyle: "expanded", noLineComments: true}).on("error", sass.logError))
    .pipe(cssmin({keepSpecialComments: 0}))
    .pipe(rename({suffix: ".min"}))
    .pipe(gulp.dest("./"));
});

gulp.task("test", function() {
  gulp
    .src("./_tangram.scss")
    .pipe(copy("./test/stylesheets"));

  gulp
    .src("test/**/*.scss")
    .pipe(sass({outputStyle: "expanded", noLineComments: true}).on("error", sass.logError))
    .pipe(gulp.dest("./test"))
});

gulp.task("default", ["concat", "compile"]);
