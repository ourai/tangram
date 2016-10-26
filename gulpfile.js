"use strict";

const gulp = require("gulp");
const concat = require("gulp-concat");
const sass = require("gulp-sass");
const cssmin = require("gulp-cssmin");
const rename = require("gulp-rename");

gulp.task("concat", function() {
  gulp
    .src([
      "./bower_components/trick-0.4.2/_trick.scss",
      "./src/utils/_box-model.scss",
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
    .pipe(gulp.dest("./"));
});

gulp.task("minify", function() {
  gulp
    .src("./tangram.css")
    .pipe(cssmin({keepSpecialComments: 0}))
    .pipe(rename({suffix: ".min"}))
    .pipe(gulp.dest("./"))
});

gulp.task("default", ["concat", "compile", "minify"]);
