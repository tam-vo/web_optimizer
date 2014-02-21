module WebStuff
  module LessToScss
    def self.convert(path)
      raise "Invalid less file" unless File.extname(path) == ".less"

      content = File.read(path)
      content.gsub!(/@/, "$").gsub!(/\.([\w\-]*)\s*\((.*)\)\s*\{/, "@mixin \1\(\2\)\n{")
      content.gsub!(/\.([\w\-]*\(.*\)\s*;)/, "@include \1").gsub!(/~"(.*)"/, "\#{\"\1\"}")
      content.gsub!("$import", "@import")
      content.gsub!("$media", "@media")
      content.gsub!("$keyframes", "@-moz-")
      content.gsub!("$-o-", "@-o-")
      content.gsub!("$-webkit-", "@-webkit-")

      Common::Util.write_file(File.join(File.dirname(path), File.basename(path, ".*") + ".scss"), content)
    end
  end
end

