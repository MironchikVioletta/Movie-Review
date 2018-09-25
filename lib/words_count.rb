# frozen_string_literal: true

def most_frequent_word(str)
  word_frequents = str.split(' ').each_with_object(Hash.new(0)) do |item, hash|
    hash[item] += 1
  end
  word_frequents.key(word_frequents.values.max)
end

def define_most_frequent_word!(str)
  str.define_singleton_method(:most_frequent_word) do
    word_frequents = split(' ').each_with_object(Hash.new(0)) do |word, words_with_frequency|
      words_with_frequency[word] += 1
    end
    word_frequents.key(word_frequents.values.max)
  end
  str
end

# old version
# def most_frequent_word(str)
#
#     word_freqents = Hash.new 0
#     str.split.each do |word|
#         word_freqents[word] += 1
#     end
#
#     word_frequents.key(word_frequents.values.max)
# end

# words = ['aa', 'b', 'aa',  'violetta']
