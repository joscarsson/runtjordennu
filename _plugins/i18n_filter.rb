require 'i18n'

LOCALE = Jekyll.configuration({})['lang']

module Jekyll
  module I18nFilter
    def localize(input, format=nil)
      load_translations
      format = (format =~ /^:(\w+)/) ? $1.to_sym : format
      I18n.locale = LOCALE
      I18n.l input, :format => format
    end

    def load_translations
      if I18n.backend.send(:translations).empty?
        I18n.backend.load_translations Dir[File.join(File.dirname(__FILE__),'../_locales/*.yml')]
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::I18nFilter)
