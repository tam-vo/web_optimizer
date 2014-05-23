require "fileutils"
require "active_support"

module WebStuff
  extend Common::GoogleTranslator

  module YamlTranslations
    @@content = ""

    def self.translations_locale_dir(dir_path, from_locale, to_locale)
      raise Exception.new("Invalid dir path") unless File.directory? dir_path

      Dir[File.join(dir_path, "**/*.#{from_locale}.yml"), File.join(dir_path, "**/#{from_locale}.yml")].each do |locale_path|
        if File.basename(locale_path) == "#{from_locale}.yml"
          dest_file = File.join(dir_path, "#{to_locale}.yml")
        else
          dest_file = File.join(dir_path, "#{File.basename(locale_path, ".#{from_locale}.yml")}.#{to_locale}.yml")
        end

        puts "---#{locale_path}"
        from_hash = YAML.load_file(locale_path)
        if File.exists?(dest_file)
          to_hash = YAML.load_file(dest_file)
        end
        to_hash = {} unless to_hash

        self.traverse_hash(from_hash, to_hash, from_locale, to_locale)
        to_hash.delete(from_locale)
        content = output_hash(from_hash, to_hash, from_locale, to_locale)
        # Common::Util.write_file(dest_file, Common::Util.yaml(to_hash))
        Common::Util.write_file(dest_file, content)
      end
    end

    protected
    def self.traverse_hash(from_hash, to_hash, from_locale, to_locale)
      from_hash.each do |key, value|
        if value.is_a?(Hash)
          key = to_locale if key == from_locale
          to_hash[key] ||= {}
          self.traverse_hash(value, to_hash[key], from_locale, to_locale)
        elsif value.is_a?(String)
          next if to_hash[key].present?
          translation = Common::GoogleTranslator.translate(value, from_locale, to_locale)
          to_hash[key] = Common::GoogleTranslator.standarize_translation(value, translation)
        end
      end
    end

    def self.output_hash(from_hash, to_hash, from_locale, to_locale)
      @@content = ""
      output_hash_recursive(from_hash, to_hash, from_locale, to_locale, 0)
    end

    def self.output_hash_recursive(from_hash, to_hash, from_locale, to_locale, level)
      to_hash.each do |key, value|
        if value.is_a?(Hash)
          @@content += "  "*level + "#{key}:\n"
          key = from_locale if key == to_locale
          self.output_hash_recursive(from_hash[key], value, from_locale, to_locale, level+1)
        elsif value.is_a?(String)
          @@content += "  "*level + "# #{from_hash[key]}\n"
          @@content += "  "*level + "#{key}: #{value}\n"
        end
      end
      @@content
    end
  end
end

