require "fileutils"
require "active_support"

module WebStuff
  extend Common::GoogleTranslator

  module YamlTranslations
    def self.translations_locale_dir(dir_path, from_locale, to_locale)
      raise Exception.new("Invalid dir path") unless File.directory? dir_path
      puts "translations_locale_dir"

      Dir[File.join(dir_path, "**/*.#{from_locale}.yml"), File.join(dir_path, "**/#{from_locale}.yml")].each do |locale_path|
        if File.basename(locale_path) == "#{from_locale}.yml"
          dest_file = File.join(dir_path, "#{to_locale}.yml")
        else
          dest_file = File.join(dir_path, "#{File.basename(locale_path, ".#{from_locale}.yml")}.#{to_locale}.yml")
        end
        if File.exists?(dest_file)
          puts "[skip] #{locale_path}"
          next
        end
        puts "---#{locale_path}"
        hash = YAML.load_file(locale_path)
        result_hash = self.traverse_hash(hash, from_locale, to_locale)
        Common::Util.write_file(dest_file, Common::Util.yaml(result_hash))
      end
    end

    protected
    def self.traverse_hash(hash, from_locale, to_locale)
      hash.each do |key, value|
        if value.is_a?(Hash)
          self.traverse_hash(value, from_locale, to_locale)
        elsif value.is_a?(String)
          translation = Common::GoogleTranslator.translate(value, from_locale, to_locale)
          hash[key] = Common::GoogleTranslator.standarize_translation(value, translation)
        end
      end
    end
  end
end

