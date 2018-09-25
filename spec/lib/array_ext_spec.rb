# frozen_string_literal: true

require 'rails_helper'
# require "#{Rails.root}/doc/Task6/monkey_patching"
require_relative 'array_monkey_patching'

describe 'the metaprogramming methods process' do
  let(:test_array) { [1, 2, 3] }

  context 'double_each method' do
    it 'output' do
      expect { test_array.double_each { |i| puts i } }
        .to output("1\n2\n3\n1\n2\n3\n").to_stdout
    end

    it 'return' do
      returned_array = test_array.double_each { |e| puts e }
      expect(returned_array)
        .to eq([1, 2, 3, 1, 2, 3])
    end
  end
end
