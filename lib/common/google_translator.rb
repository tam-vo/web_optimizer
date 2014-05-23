require "mechanize"
require "active_support/core_ext"
require "common/mechanize_helper"
# require File.expand_path(File.join(File.dirname(__FILE__), "mechanize_helper.rb"))
include Common::MechanizeHelper

module Common
  module GoogleTranslator
    def self.translate(str, from_locale, to_locale)
      str = str.strip
      return "" if str.blank?
      params = {
        "client" => "t",
        "sl" => from_locale,
        "tl" => to_locale,
        "hl" => "en",
        "sc" => "2",
        "ie" => "UTF-8",
        "oe" => "UTF-8",
        "oc" => "1",
        "otf" => "2",
        "ssel" => "3",
        "tsel" => "6",
        "q" => str
      }
      result = agent.get("http://translate.google.com.vn/translate_a/t", params)
      json = JSON(result.body.match(/^\[(\[\[.*?\]\])/)[1])
      json[0][0]
    end

    def self.standarize_translation(translation)
      translation = translation.gsub(/\n/, "").gsub(/% s/, "%s").gsub(/  /, " ").
        gsub(/< ?(\/?) (\w+) >/, '<\1\2>').gsub(/ ([\.,!?])( |$)/, '\1')

      translation_data = translation.scan(/{ ?{.*?} ?}/)
      value_data = value.scan(/{{.*?}}/)
      if translation_data.present?
        translation_data.each_with_index do |trans, index|
          translation = translation.gsub(trans, value_data[index])
        end
      end
      translation
    end
  end
end

