# frozen_string_literal: true

module MyEnumerable
  def my_map
    out = []
    my_each { |e| out << yield(e) }
    self.class[*out]
  end

  def my_select
    out = []
    my_each { |e| out << e if yield(e) }
    self.class[*out]
  end

  def my_find
    out = []
    my_each do |e|
      out << e if yield(e)
      # break if yield(e)
      break if out.length == 1
    end
    self.class[*out]
  end

  def my_uniq
    uniq_array = []
    if block_given?
      returned_values_from_block = []
      my_each do |e|
        unless returned_values_from_block.include?(yield(e))
          returned_values_from_block << yield(e)
          uniq_array << e
        end
      end
    else
      my_each do |e|
        uniq_array << e unless uniq_array.include?(e)
      end
    end
    self.class[*uniq_array]
  end

  def my_uniq!
    uniq_array = []
    if block_given?
      returned_values_from_block = []
      my_each do |e|
        unless returned_values_from_block.include?(yield(e))
          returned_values_from_block << yield(e)
          uniq_array << e
        end
      end
    else
      my_each do |e|
        uniq_array << e unless uniq_array.include?(e)
      end
    end

    return nil if uniq_array.size.zero?

    @array = uniq_array
    self
  end

  def my_reject
    out = []
    my_each { |e| out << e unless yield(e) }
    self.class[*out]
  end
end
# instance = MyArray.new(1, 1, 2, 2, 3)

class MyArray
  include MyEnumerable
  attr_accessor :array

  def initialize(*args)
    @array = args
  end

  def ==(other)
    array == other.array
  end

  def self.[](*args)
    new(*args)
  end

  def my_length
    count = 0
    loop do
      count += 1
      break if @array.size == count
    end
    count
  end

  def my_each
    return enum_for(:my_each) unless block_given?
    i = 0
    loop do
      yield(@array[i])
      i += 1
      break if i == my_length
    end
    self
  end

  class << self
    private

    def new(*args, &block)
      super
    end
  end
end
