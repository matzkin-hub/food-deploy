class IngredientStocksController < ApplicationController
  def new
    @ingredient = Ingredient.find(params[:id])
    @ingredient_stock = @ingredient.ingredient_stocks.build
  end
end
