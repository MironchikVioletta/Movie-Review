# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    user { nil }
    title { 'Test Movie' }
    description { 'description' }
    movie_length { '1:20' }
    director { 'director' }
    rating { '5' }
    image { File.new("#{Rails.root}/spec/support/fixtures/test_movie_img.jpg") }
  end
end
