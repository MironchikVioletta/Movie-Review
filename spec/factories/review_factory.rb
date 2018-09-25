# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    user
    rating { '5' }
    comment { 'Cool' }
  end
end
