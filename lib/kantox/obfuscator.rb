# frozen_string_literal: true

require 'dry-initializer'

module Kantox
  # Obfuscator
  # ==========
  #
  # A simple class that is able to obfuscate sensitive data for the purpose
  # of logging or showing to a low-authorization user.
  #
  # Synopsis
  # --------
  #
  # obfuscator = Kantox::Obfuscator.new
  # obfuscator.call("1234567890")
  # # => "12xxxx7890"
  #
  # obfuscator = Kantox::Obfuscator.new(keys: [:a, :b])
  # obfuscator.call(a: "1234567890", c: "0987654321")
  # # => { a: "12xxxx7890", c: "0987654321" }
  # # (note that the key :c is not obfuscated)
  class Obfuscator
    extend Dry::Initializer

    param :keep_start, reader: :private, default: -> { 2 }
    param :keep_end, reader: :private, default: -> { 4 }
    option :replacement, reader: :private, default: -> { 'x' }
    option :keys, reader: :private, default: -> { [] }

    def call(target)
      case target
      when String
        obfuscate_string(target)
      when Numeric
        obfuscate_string(target.to_s)
      when Hash
        obfuscate_hash(target)
      else
        target
      end
    end

    private

    def obfuscate_hash(hash)
      hash.each_with_object({}) do |(key, value), result|
        result[key] = keys.include?(key) ? call(value) : value
      end
    end

    def obfuscate_string(string)
      string.gsub(replacer, replacement)
    end

    def replacer
      @replacer ||= /(?<=.{#{keep_start}})\w(?=.{#{keep_end}})/
    end
  end
end
