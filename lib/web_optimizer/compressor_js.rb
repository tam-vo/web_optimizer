require "debugger"
require "fileutils"
require "active_support"

BASE_DIR = "/Users/tamvo/code/php/wp/auto_wordpress/wp-content"
MY_JS_PATHS = ["custom/dbv",
  "themes/creativepress/templates/javascripts",
  "plugins/client-management/js",
  "plugins/pie-register", # Err
  "plugins/socialpop",
  "plugins/wp-maintenance-mode",
  "themes/creativepress/includes/eztables/js/placeholder.jquery.js",
  "themes/creativepress/includes/slides/js/cycle.slideshow.js",

  # "wp-content/plugins/broken-link-checker",
  # "wp-content/plugins/pricing-table",
  # "wp-content/plugins/ninety-feedback",
]

def check_include_dir(ignore_dirs, child_path)
  ignore_dirs.each do |ignore_dir|
    return true unless child_path.match(/^#{ignore_dir}\/?/).nil?
  end

  false
end

def compile_dir(dir, trict=false)
  return unless File.directory? dir

  ignore_paths = MY_JS_PATHS.map { |path| File.join(BASE_DIR, path) }
  unless check_include_dir(ignore_paths, dir)
    Dir[File.join(dir, "**/*")].each do |js_path|
      if File.directory?(js_path)
        compile_dir(js_path, trict)
      elsif !js_path.end_with?("pack.js") && !js_path.end_with?("min.js") &&
        File.extname(js_path) == ".js" && !check_include_dir(ignore_paths, js_path)

        bak_js_path = "#{js_path}.bak"
        from_file = bak_js_path
        compile = true

        if File.exists?(bak_js_path)
          compile = trict
        else
          FileUtils.copy_file(js_path, bak_js_path)
        end

        if compile
          puts "+ Compress: #{js_path}"
          # puts  "java -jar ~/code/tools/compiler-latest/compiler.jar --js #{from_file} --js_output_file #{js_path}"
          # sleep 2
          `java -jar /Users/tamvo/code/tools/compiler-latest/compiler.jar --js #{from_file} --js_output_file #{js_path}`
        end

      end
    end
  else
    puts "- Ignore: #{dir}"
  end
end

compile_dir(BASE_DIR, false)

