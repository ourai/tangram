# Tangram

中文为「[七巧板](http://baike.baidu.com/subview/6906/5036033.htm)」，是一种智力游戏。该项目所提供的就是像七巧板中的板块那样的单元，我称之为「模块」。每个「模块」都有它自己的一些特性，需要使用者了解并发挥自己的想象力将它们组装起来拼接成各种各样的页面。

## 关于

### 有什么东西

本项目中的「模块」有两类——

* 用于网页整体，充当一个页面骨架的「框架」：
    * 三明治布局（sandwich），是 Sticky Footer 的一种实现，具有固定高度的页头和页脚（永远在页面最底部），内容区域默认撑满剩余部分，超出时高度随内容；
    * 仿框架布局（frameset），具有固定高度的页头和页脚（永远在页面最底部），内容区域超出时出现滚动条；
    * 滚动布局（scroll），侧边栏宽、高固定，内容区域宽度自适应且高度固定得两栏布局。
* 用于区域划分或组件的「模块」（计划开发中）

### 与组件的区别

可能有些人会把「模块」与 Bootstrap 等中的「组件」弄混——它们不是同一种东西。「模块」只具备布局上的一些特性，没有任何颜色、字体等方面的定制，「组件」是基于它开发的。

## 用法

本项目有两种使用方式：CSS class 和 Sass mixin。

### 安装

```bash
bower install --save tangram-0.2.2=ourai/tangram#0.2.2
```

### 引用

如果是使用 CSS 的话，在 HTML 文件中引入 `tangram.min.css`。详见《[CSS Classes](./docs/classes.md)》。

```html
<link rel="stylesheet" href="bower_components/tangram-0.2.2/tangram.min.css">
```

还可以引入 Sass mixin 根据需要自定义 class 的名字。详见《[Sass Mixins](./docs/mixins.md)》。

```scss
// 可以直接引用 Ruby 版的 Compass
@import "compass";
// 也可以只引用 Compass 的 mixin
@import "bower_components/compass-mixins-0.12.10/lib/compass";
// 之后引入本项目所提供的 mixin
@import "bower_components/tangram-0.2.2/tangram";
```
