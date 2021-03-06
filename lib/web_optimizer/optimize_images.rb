require "fileutils"
require "active_support"

TMP_EXT_NAME = "-tmp.png"

module WebOptimizer
  def self.compress_img(dir, ignore_paths=[])
    raise Exception.new("Invalid dir path") unless File.directory? dir

    ignore_paths = ignore_paths.map do |path|
      tmp_path = Pathname.new(path)
      tmp_path.absolute? ? path : File.join(dir, path)
    end

    unless check_include_dir(ignore_paths, dir)
      Dir[File.join(dir, "**/*")].each do |image_path|
        next if check_include_dir(ignore_paths, image_path)

        if File.directory?(image_path)
          compress_img(image_path)
        elsif (file_ext = File.extname(image_path)) == ".png"
          file_name = File.basename(image_path)
          `/usr/local/bin/pngquant #{image_path} --ext #{TMP_EXT_NAME}`
          new_file_path = image_path.gsub(file_ext, "-tmp.png")
          `mv #{new_file_path} #{image_path}`
          puts "[pngquant] #{image_path}"
        elsif ['png'].any? { |ext| file_ext == ".#{ext}" }
          puts "[image_optim] #{image_path}"
          `/Users/tamvo/.rvm/gems/ruby-1.9.3-p194@general/bin/image_optim #{image_path}`
        end
      end
    end
  end
end

