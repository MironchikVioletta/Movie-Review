# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password { 'password' }
    age { 21 }
    city { 'NY' }
    premium { false }
    blocked { false }

    factory :user_with_reviews do
      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      transient do
        reviews_count { 1 }
      end
      # to create and we make sure the user is associated properly to the post
      after(:create) do |user, evaluator|
        create_list(:review, evaluator.reviews_count, user: user)
      end
    end

    # factory :user_with_movies do
    #     transient do
    #     movies_count { 1 }
    #   end
    #   after(:create) do |user, evaluator|
    #     create_list(:movie, evaluator.movies_count, user: user)
    #   end
    # end
  end
end
