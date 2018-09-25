# frozen_string_literal: true

class AddAgePremiumBlockedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :premium, :boolean
    add_column :users, :blocked, :boolean
  end
end
