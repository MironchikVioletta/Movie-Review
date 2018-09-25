# frozen_string_literal: true

require 'rails_helper'

describe 'Sql practice' do
  let(:connection) { ActiveRecord::Base.connection }

  describe 'users with age less than 15' do
    let!(:expected_users) do
      [
        create(:user, age: 10),
        create(:user, age: 11),
        create(:user, age: 12),
        create(:user, age: 13)
      ].map(&:id)
    end
    let!(:users) do
      [
        create(:user, age: 23),
        create(:user, age: 24),
        create(:user, age: 23)
      ].map(&:id)
    end

    context 'raw sql' do
      it do
        result = connection.execute('select id, age from users where age < 15').map { |u| u['id'] }
        expect(result).to match_array(expected_users)
      end
    end

    context 'ars' do
      it do
        result = User.where('age < ?', 15).pluck(:id)
        expect(result).to match_array(expected_users)
      end
    end
  end
end
