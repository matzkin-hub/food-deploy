# frozen_string_literal: true

class Tasklist < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 30 }
  validates :quantity, presence: true
  validates :quantity, numericality: {
    greater_than_or_equal_to: 0
  }
end
