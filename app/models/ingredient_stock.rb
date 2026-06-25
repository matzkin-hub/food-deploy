 class IngredientStock < ApplicationRecord
   belongs_to :ingredient
   validates :expire_on, presence: true
   validates :quantity, presence: true

   def status_color
     if expire_on <= 1.day.from_now.to_date
       'danger'
     elsif expire_on <= 4.days.from_now.to_date
       'warning'
     elsif expire_on <= 7.days.from_now.to_date
       'primary'
     else
       'secondary'
     end
   end
   
 end
