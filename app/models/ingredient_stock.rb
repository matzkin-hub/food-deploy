 class IngredientStock < ApplicationRecord
   belongs_to :ingredient
   validates :expire_on, presence: true
   validates :quantity, presence: true
 end
