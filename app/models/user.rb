# frozen_string_literal: true

class User < ActiveRecord::Base
  default_scope { where(blocked: false) }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :movies
  has_many :reviews, dependent: :destroy

  scope :premium, -> { where(premium: true) }
  scope :kids, -> { where('age < 12') }
  scope :rude, -> { joins(:reviews).where('reviews.comment like ?', '%It sucks%') }

  validates :city, length: { maximum: 20, too_long: '%{count} characters is the maximum allowed' }
  validates :age, numericality: { greater_than_and_equal_to: 1, less_than: 100 }
end
