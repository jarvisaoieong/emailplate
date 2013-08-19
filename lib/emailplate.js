var Emailplate, async, cons, fs, glob, juice, stylus, _;

_ = require('underscore');

glob = require('glob');

async = require('async');

fs = require('fs');

cons = require('consolidate');

stylus = require('stylus');

juice = require('juice');

module.exports = Emailplate = (function() {
  Emailplate.prototype.defaults = {
    views: './emailplates'
  };

  function Emailplate(options) {
    this.options = options != null ? options : {};
    this.options = _.defaults(this.options, this.defaults);
  }

  Emailplate.prototype.get = function(name) {
    return this.options[name];
  };

  Emailplate.prototype.set = function(option, val) {
    if (arguments.length === 1) {
      _.extend(this.options, option);
    } else {
      this.options[option] = val;
    }
    return this;
  };

  Emailplate.prototype.themes = function(fn) {
    return glob("" + this.options.views + "/**/emailplate.*", function(err, files) {
      var results;
      results = _.map(files, function(file) {
        return require(file);
      });
      return fn(null, results);
    });
  };

  Emailplate.prototype.theme = function(name, fn) {
    return fn(null, require("" + this.options.views + "/" + name + "/emailplate"));
  };

  Emailplate.prototype.render = function(theme, data, fn) {
    var info, themeDir;
    if (_.isFunction(data)) {
      fn = data;
      data = {};
    }
    themeDir = "" + this.options.views + "/" + theme;
    info = require("" + themeDir + "/emailplate");
    data = _.defaults(data, info.locals);
    return async.parallel({
      html: function(cb) {
        return fs.readFile("" + themeDir + "/" + info.template.file, 'utf-8', function(err, result) {
          return cons[info.template.engine].render(result, data, cb);
        });
      },
      css: function(cb) {
        var parallel;
        if (!_.isArray(info.style.file)) {
          info.style.file = [info.style.file];
        }
        parallel = _.map(info.style.file, function(path) {
          return function(fn) {
            return fs.readFile("" + themeDir + "/" + path, 'utf-8', fn);
          };
        });
        return async.parallel(parallel, function(err, results) {
          var content, stylusObj;
          content = results.join('\n');
          stylusObj = stylus(content);
          if (_.isObject(data.stylus)) {
            _.each(data.stylus, function(value, key) {
              return stylusObj.define(key, value);
            });
          }
          return stylusObj.render(cb);
        });
      }
    }, function(err, results) {
      var html;
      html = juice(results.html, results.css);
      return fn(null, html);
    });
  };

  return Emailplate;

})();
