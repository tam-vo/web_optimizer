require "web_optimizer"
require "debugger"

dir = "/Users/tamvo/code/lib/ruby/web_optimizer/data"; WebOptimizer.compress_css(dir)
dir = "/Users/tamvo/code/lib/ruby/web_optimizer/data"; WebOptimizer.compress_js(dir)
dir = "/Users/tamvo/code/lib/ruby/web_optimizer/data"; WebOptimizer.compress_img(dir)

dir_path = "/Users/tamvo/code/lib/me/web_optimizer/data"
WebStuff::AngularLocaleTranslations.translations_locale_dir(dir_path, "en", "ja")

