# AntigateApi

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

Compress CSS
```
WebOptimizer.compress_css(dir, ignore_paths=[])
WebOptimizer.compress_js(dir, ignore_paths=[])
WebOptimizer.compress_img(dir, ignore_paths=[])
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

