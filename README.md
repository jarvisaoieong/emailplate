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

Copyright (c) 2013 Jarvis Ao Ieong   
Licensed under the MIT license.
