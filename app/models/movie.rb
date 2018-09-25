# frozen_string_literal: true

class Movie < ActiveRecord::Base
  searchkick settings: { index: { max_result_window: 100_000 } }
  belongs_to :user, foreign_key: :user_id
  has_many :reviews

  has_attached_file :image, styles: { medium: '400x600#', small: '200x300#' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
