# frozen_string_literal: true

require 'rails_helper'

describe 'Sql practice' do
  let(:connection) { ActiveRecord::Base.connection }

  describe 'The 5 youngest users' do
    let!(:expected_users) do
      [
        create(:user, age: 10),
        create(:user, age: 11),
        create(:user, age: 12),
        create(:user, age: 13),
        create(:user, age: 14)
      ].map(&:id)
    end
    let!(:users) do
      [
        create(:user, age: 23),
        create(:user, age: 24)
      ].map(&:id)
    end

    context 'raw sql' do
      it do
        result = connection.execute('SELECT id, age FROM users ORDER BY age LIMIT 5').map { |u| u['id'] }
        expect(result).to match_array(expected_users)
      end
    end
  end

  describe 'The top 3 movies(by rating) process' do
    let!(:expected_movies) do
      [
        create(:movie, rating: '9'),
        create(:movie, rating: '9'),
        create(:movie, rating: '5')
      ].map(&:id)
    end
    let!(:movies) do
      [
        create(:movie, rating: '10')
      ].map(&:id)
    end

    context 'raw sql' do
      it do
        result = connection.execute('SELECT id, rating FROM movies ORDER BY rating DESC LIMIT 3').map { |m| m['id'] }
        expect(result).to match_array(expected_movies)
      end
    end
  end

  describe "The reviews ordered by it's length process" do
    let!(:expected_reviews) do
      [
        create(:review, comment: '123456'),
        create(:review, comment: '12345')
      ].map(&:id)
    end

    context 'raw sql' do
      it 'In ascending order' do
        result = connection.execute('SELECT * FROM reviews ORDER BY length(comment)').map { |r| r['id'] }
        expect(result).to match_array(expected_reviews)
      end

      # context 'ActiveRecord sintax' do
      #   it 'In descending order' do
      #       Review.order(length(comment))
      #   end
      # end
    end
  end

  describe 'The count of users blocked users older than 18 process' do
    let!(:expected_users) do
      [
        create(:user, age: 19, blocked: true),
        create(:user, age: 20, blocked: true)
      ].map(&:id)
    end
    let!(:users) do
      [
        create(:user, age: 15, blocked: true),
        create(:user, age: 16, blocked: true),
        create(:user, age: 17, blocked: false),
        create(:user, age: 25, blocked: false)
      ].map(&:id)
    end

    context 'raw sql' do
      it do
        result = connection.execute("SELECT id, blocked, age FROM users WHERE blocked is 't' AND age > 18").map { |u| u['id'] }
        expect(result).to match_array(expected_users)
      end
    end
  end

  describe 'users without reviews' do
    let!(:user_with_review) { create(:user_with_reviews) }
    let!(:user_without_review) { create(:user) }

    context 'ActiveRecord syntax' do
      it do
        result = User.joins('LEFT JOIN reviews ON users.id = reviews.user_id').where('reviews.id is null').pluck(:id)
        expect(result).to match_array([user_without_review['id']])
      end
    end
  end

  describe 'users with 2 reviews' do
    let!(:user_with_2_reviews) { create(:user_with_reviews, reviews_count: 2) }
    let!(:user_with_1_review) { create(:user_with_reviews) }

    let!(:user_without_review) { create(:user) }

    context 'ActiveRecord syntax' do
      it do
        result = User
                 .joins(:reviews).group('reviews.user_id')
                 .having('count(reviews.id) = ?', 2).pluck(:id)
        expect(result).to eq([user_with_2_reviews.id])
      end
    end
  end

  describe 'users with more than 2 reviews' do
    let!(:user_with_3_reviews) { create(:user_with_reviews, reviews_count: 3) }
    let!(:user_with_1_review) { create(:user_with_reviews) }

    let!(:user_without_review) { create(:user) }

    context 'ActiveRecord syntax' do
      it do
        result = User
                 .joins(:reviews).group('reviews.user_id')
                 .having('count(reviews.id) > ?', 2).pluck(:id)
        expect(result).to eq([user_with_3_reviews.id])
      end
    end
  end

  describe 'users are twice ordered by age' do
    let!(:expected_users) do
      [
        create(:user, age: 12),
        create(:user, age: 20),
        create(:user, age: 99),
        create(:user, age: 10)
      ].map(&:id)
    end

    context 'ActiveRecord syntax' do
      it do
        result = User
                 .order('age = 12')
                 .order('age = 20')
                 .pluck(:id)
        expect(result).to match_array(expected_users)
      end
    end
  end

  describe 'users that has reviews on the movie with the worst rating' do
    let!(:user_without_review_on_bad_movie) { create(:user) }

    let(:good_reviews) { [build(:review, user: user_without_review_on_bad_movie)] }
    let!(:good_movie) { create(:movie, reviews: good_reviews, rating: '5') }

    let!(:user) { create(:user) }
    let(:reviews) { [build(:review, user: user)] }
    let!(:worst_movie) { create(:movie, reviews: reviews, rating: '1') }

    context 'ActiveRecord syntax' do
      it 'by WHERE case' do
        result = User
                 .joins(reviews: :movie)
                 .where('movies.rating = ?', Movie.minimum('rating'))

        expect(result).to eq([user])
      end

      it 'subquery' do
        result = User
                 .joins(reviews: :movie).where('movies.rating = (SELECT MIN(rating) FROM movies)')
      end
    end
  end
end
