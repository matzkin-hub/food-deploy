class Ingredient < ApplicationRecord
  belongs_to :user
  has_many :ingredient_stocks, dependent: :destroy
  validates :name, presence: true
end
