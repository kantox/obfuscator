# frozen_string_literal: true

require_relative 'spec_helper'

require 'kantox-obfuscator'

RSpec.describe Kantox::Obfuscator do
  it 'obfuscates strings by default' do
    expect(subject.call('1234567890')).to eq('12xxxx7890')
  end

  it 'obfuscates numbers by default' do
    expect(subject.call(1_234_567_890)).to eq('12xxxx7890')
    expect(subject.call(1_234_567_890.12)).to eq('12xxxxxxx0.12')
  end

  context 'with alternative replacement' do
    subject do
      described_class.new(replacement: '-')
    end

    it 'obfuscates strings' do
      expect(subject.call('1234567890')).to eq('12----7890')
    end
  end

  context 'with non-default obfuscation window' do
    subject do
      described_class.new(1, 3)
    end

    it 'obfuscates strings' do
      expect(subject.call('1234567890')).to eq('1xxxxxx890')
    end
  end

  context 'with a blacklist' do
    subject do
      described_class.new(keys: %i[black listed])
    end

    it 'obfuscates hashes' do
      input = {
        black: 'this will be obfuscated',
        white: 'this will be kept'
      }
      expect(subject.call(input)).to include(
        black: 'thxx xxxx xx xxxxxxated',
        white: 'this will be kept'
      )
    end
  end
end
