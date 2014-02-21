# Web Optimizer

Some util script to optime your assets (images, js files, css files).
Contribute more are welcome, please drop me an email at
vo.mita.ov at gmail.com if you need help or want to contribute

## Installation

    $ gem install web_optimizer

## Requirement

    /Users/tamvo/code/tools/yuicompressor-2.4.8pre.jar
    /Users/tamvo/code/tools/compiler-latest/compiler.jar
    gem install pngquant
    (/usr/local/bin/pngquant)
    gem install image_optim
    (/Users/tamvo/.rvm/gems/ruby-1.9.3-p194@general/bin/image_optim)

## Usage

Compress Stuffs
```
WebOptimizer.compress_css(dir, ignore_paths=[])
WebOptimizer.compress_js(dir, ignore_paths=[])
WebOptimizer.compress_img(dir, ignore_paths=[])
```

Translation Yaml files
```
require "web_stuff"
dir_path = "/Users/tamvo/code/rails/minesweeper/config/locales"
WebStuff::YamlTranslations.translations_locale_dir(dir_path, "en", "it")
```

Convert Less to Scss
```
require "web_stuff"
WebStuff::LessToScss.convert("less_path")
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

