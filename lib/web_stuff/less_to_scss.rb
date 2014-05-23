module WebStuff
  module LessToScss
    def self.convert(path)
      raise "Invalid less file" unless File.extname(path) == ".less"

      content = File.read(path)
      content.gsub!(/@\{?(\w+)\}?/, '$\1')
      content.gsub!(/^\.([\w\-]*)\s*\((.*)\)\s*\{/, '@mixin \1(\2){')
      content.gsub!(/^\.([\w\-]*\(.*\)\s*;)/, '@include \1')
      content.gsub!(/~"(.*)"/, '\#{\"\1\"}')
      content.gsub!(/\$import +["\'](.*?)\.less["\']/, '@import "\1.scss"')
      content.gsub!('$media', '@media')
      content.gsub!('$keyframes', '@-moz-')
      content.gsub!('$-o-', '@-o-')
      content.gsub!('$-webkit-', '@-webkit-')

      puts "Please check @arguments"

      Common::Util.write_file(File.join(File.dirname(path), File.basename(path, ".*") + ".scss"), content)
    end
  end
end

