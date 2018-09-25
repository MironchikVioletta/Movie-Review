# frozen_string_literal: true

class Array
  def double_each
    x = []

    2.times do
      each do |item|
        yield(item)
        x << item
      end
    end

    x
  end
end
