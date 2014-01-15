require "debugger"
require "fileutils"
require "active_support"

TMP_EXT_NAME = "-tmp.png"

def compile_dir(dir)
  return unless File.directory? dir

  Dir[File.join(dir, "**/*")].each do |image_path|
    if File.directory?(image_path)
      compile_dir(image_path)
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

if (ARGV.length == 0)
  puts "Usage: ruby optimize_images.rb <dir>"
else
  compile_dir(ARGV[0])
end

