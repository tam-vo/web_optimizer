require "fileutils"
require "active_support"

module WebStuff
  extend Common::GoogleTranslator

  module AngularLocaleTranslations
    def self.translations_locale_dir(dir_path, from_locale, to_locale)
      raise Exception.new("Invalid dir path") unless File.directory? dir_path
      puts "translations_locale_dir"

      Dir[File.join(dir_path, "**/*.#{from_locale}.js.coffee"), File.join(dir_path, "**/#{from_locale}.js.coffee")].each do |locale_path|
        if File.basename(locale_path) == "#{from_locale}.js.coffee"
          dest_file = File.join(dir_path, "#{to_locale}.js.coffee")
        else
          dest_file = File.join(dir_path, "#{File.basename(locale_path, ".#{from_locale}.js.coffee")}.#{to_locale}.js.coffee")
        end

        to_hash = File.exists?(dest_file) ? build_hash_from_locale_file(dest_file) : {}
        from_hash = build_hash_from_locale_file(locale_path)
        from_hash.each do |key, value|
          next if to_hash[key].present?
          translation = Common::GoogleTranslator.translate(value, from_locale, to_locale)
          translation = Common::GoogleTranslator.standarize_translation(value, translation)
          to_hash[key] = translation
        end
        puts to_hash
        content = <<RUBY
@Locale ||= {}
@Locale.#{to_locale.upcase}_LOCALES = {
RUBY
        to_hash.each do |key, value|
          content += <<RUBY
  # #{from_hash[key]}
  #{key}: "#{value}"

RUBY
        end
        content += "}"
        Common::Util.write_file(dest_file, content)
      end
    end

    protected
    def self.build_hash_from_locale_file(locale_path)
      hash = {}
      File.readlines(locale_path).each do |line|
        next unless line.include?(":")
        pair = line.split(":")
        str = pair[1].match(/"(.*?)"$/)[1]
        hash[pair[0][/[\w_]+/]] = str
      end
      hash
    end
  end
end

