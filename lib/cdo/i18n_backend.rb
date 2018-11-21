require 'i18n'
require 'active_support/core_ext/numeric/bytes'
require 'cdo/key_value'

module I18nSmartTranslate
  def translate(locale, key, options = I18n::EMPTY_HASH)
    if options.fetch(:smart, false)
      options = get_smart_translate_options(locale, key, options)
    end

    super(locale, key, options)
  end

  private

  def get_smart_translate_options(locale, key, options = I18n::EMPTY_HASH)
    options = options.dup
    options.delete(:smart)

    # If I18n.t was called with an explicit scope and without specifying a
    # separator, try to find a separator character that isn't contained within
    # any of the individual scope or key values, to prevent a situation in
    # which periods in a key name can be mistakenly interpreted as separators
    if options.key?(:scope) && !options.key?(:separator)
      options[:separator] = get_valid_separator(key + options[:scope].join(''))
      puts "settled on #{options[:separator].inspect}"
    end

    options
  end

  # Potential characters to use as a separator. This list can be safely
  # expanded if the current set proves insufficient
  SEPARATORS = ".|,-_ /".split('')

  # Return a character than can be used as a separator without separating the
  # given string. If the given string contains all the attempted separator
  # values, returns nil.
  #
  # Ex:
  #
  #   get_valid_separator("plain") -> "."
  #   get_valid_separator("string.with.dots") -> "!"
  #   get_valid_separator("string.with.dots.and.exclamation!") -> "|"
  #   etc
  #
  # Used for I18n, to make sure that dynamically-provided values can safely be
  # used as the I18n key.
  def get_valid_separator(string)
    puts "Finding valid separator for #{string.inspect}"
    SEPARATORS.each do |separator|
      puts "Considering #{separator.inspect}"
      return separator unless string.include? separator
    end
  end
end

module Cdo
  class I18nSimpleBackend < ::I18n::Backend::Simple
    include I18nSmartTranslate
  end

  # I18n backend instance used by the web application.
  class I18nKeyValueCacheBackend < ::I18n::Backend::KeyValue
    include ::I18n::Backend::CacheFile
    include I18nSmartTranslate

    CACHE_DIR = pegasus_dir('cache', 'i18n/cache')

    def initialize
      store = KeyValue.new(CACHE_DIR)
      super(store, false)
      self.path_roots = [Gem.dir, deploy_dir]
    end

    def load_translations(*filenames)
      @loading = true
      super
      store.flush
      @loading = false
    end

    alias init_translations load_translations
    alias reload! load_translations

    def store_translations(*args)
      super.tap {store.flush unless @loading}
    end
  end
end
# Use custom i18n backend by enabling `CDO.i18n_key_value`.
# Default false during testing and controlled roll-out.
CDO.i18n_backend = CDO.with_default(false).i18n_key_value ?
  Cdo::I18nKeyValueCacheBackend.new :
  Cdo::I18nSimpleBackend.new
