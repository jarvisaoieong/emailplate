# Emailplate

Emailplate is a email template engine designed to make inline css html with your familiar template engine, css preprocessor.

## Installation

    $ npm install emailplate

## Quick Start

```js
var Emailplate = require('emailplate');
var emailplate = new Emailplate({
  views: __dirname + '/emailplates'
});

emailplate.render('sample', function(err, inlineCssHtml){
  console.log(inlineCssHtml);
});
```

## Themes 

This `views` option set where the template theme directory is.

The default theme layout have three files: html.<ext>, style.stylus, emailplate.json

```
emailplates
`-- blueprint
    |-- emailplate.json
    |-- html.hbs
    `-- style.styl
```

- html.(html|hbs|eco|jade|...)

  emailplate support most template engine that consolidate.js supported

[consolidate.js]: https://github.com/visionmedia/consolidate.js

- style.styl

  We use stylus because it can support css, sass, less basic syntax. It is robust.

- emailplate.(json|js|coffee)

  We need some information about the theme setting.

## API

### Initialize

```js
var Emailplate = require('emailplate')
  , emailplate = new Emailplate();
```

### Getter, Setter

```js
emailplate.set('views', __dirname + '/emailplates');
emailplate.get('views');
```

### Get all themes info

```js
emailplate.themes(function(err, infos) {
  
});
```

### Get single theme info

```js
emailplate.theme('themeName', function(err, info) {
  
});
```

### Render theme

```js
emailplate.render('themeName', {title: "emailplate test"}, function(err, html) {
  
});
```

## License

The MIT License

Copyright (c) 2012 Jarvis A.I. <kinua1230@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.