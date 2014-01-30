require "fileutils"
require "active_support"
# require "#{File.expand_path File.dirname(__FILE__)}/common.rb"

module WebOptimizer
  extend WebOptimizer::Common
  def self.compress_css(dir_path, ignore_paths=[])
    self.compress_css_recursive(dir_path, ignore_paths, true)
  end

  def self.compress_css_recursive(dir_path, ignore_paths, trict=false)
    raise Exception.new("Invalid dir path") unless File.directory? dir

    ignore_paths = ignore_paths.map do |path|
      tmp_path = Pathname.new(path)
      tmp_path.absolute? ? path : File.join(dir_path, path)
    end
    unless check_include_dir(ignore_paths, dir_path)
      Dir[File.join(dir_path, "**/*.css")].each do |css_path|
        if File.directory?(css_path)
          compress_css_recursive(css_path, trict)
        elsif !css_path.end_with?("pack.css") && !css_path.end_with?("min.css") &&
          File.extname(css_path) == ".css" && !check_include_dir(ignore_paths, css_path)

          bak_css_path = "#{css_path}.bak"
          from_file = bak_css_path
          compile = true

          if File.exists?(bak_css_path)
            compile = trict
          else
            FileUtils.copy_file(css_path, bak_css_path)
          end

          if compile
            puts "+ Compress: #{css_path}"
            # puts  "java -jar /Users/tamvo/code/tools/yuicompressor-2.4.8pre.jar #{from_file} -o #{css_path} --type css"
            # sleep 2
            `java -jar /Users/tamvo/code/tools/yuicompressor-2.4.8pre.jar #{from_file} -o #{css_path} --type css`
          end

        end
      end
    else
      puts "- Ignore: #{dir_path}"
    end
  end
end

