require "debugger"
require "fileutils"
require "active_support"

module WebOptimizer
  extend WebOptimizer::Common

  def self.compress_js(dir_path, ignore_paths=[])
    self.compress_js_recursive(dir_path, ignore_paths, false)
  end

  def self.compress_js_recursive(dir, ignore_paths, trict=false)
    return unless File.directory? dir

    ignore_paths = ignore_paths.map do |path|
      tmp_path = Pathname.new(path)
      tmp_path.absolute? ? path : File.join(dir, path)
    end
    unless check_include_dir(ignore_paths, dir)
      Dir[File.join(dir, "**/*.js")].each do |js_path|
        if File.directory?(js_path)
          self.compress_js_recursive(js_path, trict)
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
end

