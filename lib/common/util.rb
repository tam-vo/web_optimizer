module Common
  module Util
    def self.write_file(file_name, content, append=false)
      File.open(file_name, append ? "a" : "w") do |f|
        f.write(content)
      end
    rescue Exception => ex
      write_file(file_name, content.force_encoding('UTF-8'), append)
    end

    def self.yaml(hash)
      method = hash.respond_to?(:ya2yaml) ? :ya2yaml : :to_yaml
      string = hash.deep_stringify_keys.send(method)
      string.gsub("!ruby/symbol ", ":").sub("---","").split("\n").map(&:rstrip).join("\n").strip
    end
  end
end

