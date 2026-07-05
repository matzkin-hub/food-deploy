# frozen_string_literal: true

class Ingredient < ApplicationRecord
  belongs_to :user
  has_many :ingredient_stocks, dependent: :destroy
  has_one_attached :image
  validates :name, presence: true
end
