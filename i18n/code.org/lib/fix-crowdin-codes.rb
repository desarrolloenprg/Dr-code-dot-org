#! /usr/bin/env ruby
require 'fileutils'

locales = {
	'ar' => 'ar-SA',
	'as' => 'as-IN',
	'az' => 'az-AZ',
	'bg' => 'bg-BG',
	'bn' => 'bn-BD',
	'bs' => 'bs-BA',
	'ca' => 'ca-ES',
	'cs' => 'cs-CZ',
	'da' => 'da-DK',
	'de' => 'de-DE',
	'el' => 'el-GR',
	'en' => 'en-US',
	'es' => 'es-ES',
	'et' => 'et-EE',
	'eu' => 'eu-ES',
	'fa' => 'fa-IR',
	'fi' => 'fi-FI',
	'fil' => 'fil-PH',
	'fr' => 'fr-FR',
	'gl' => 'gl-ES',
	'he' => 'he-IL',
	'hi' => 'hi-IN',
	'hr' => 'hr-HR',
	'hu' => 'hu-HU',
	'hy' => 'hy-AM',
	'id' => 'id-ID',
	'is' => 'is-IS',
	'it' => 'it-IT',
	'ja' => 'ja-JP',
	'kk' => 'kk-KZ',
	'km' => 'km-KH',
	'ko' => 'ko-KR',
	'lt' => 'lt-LT',
	'lv' => 'lv-LV',
	'mk' => 'mk-MK',
	'ms' => 'ms-MY',
	'mt' => 'mt-MT',
	'ne' => 'ne-NP',
	'nl' => 'nl-NL',
	'nn' => 'nn-NO',
	'no' => 'no-NO',
	'pl' => 'pl-PL',
	'ps' => 'ps-AF',
	'pt' => 'pt-BR',
	'ro' => 'ro-RO',
	'ru' => 'ru-RU',
	'sk' => 'sk-SK',
	'sl' => 'sl-SI',
	'sq' => 'sq-AL',
	'sr' => 'sr-SP',
	'sv' => 'sv-SE',
	'ta' => 'ta-IN',
	'th' => 'th-TH',
	'tr' => 'tr-TR',
	'ur' => 'ur-PK',
	'uk' => 'uk-UA',
	'vi' => 'vi-VN',
	'zh' => 'zh-TW'
}

locales.each_pair do |two_letters_code, locale_code|
	FileUtils.cp_r "../locales/#{two_letters_code}/.", "../locales/#{locale_code}"
	FileUtils.rm_r "../locales/#{two_letters_code}"
end