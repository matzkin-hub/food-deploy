class ChangeExpireOnNullToIngredientStocks < ActiveRecord::Migration[8.1]
  def change
    change_column_null :ingredient_stocks, :expire_on, true
  end
end
