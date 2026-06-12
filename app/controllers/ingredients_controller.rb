class IngredientsController < ApplicationController
  before_action :authenticate_user!
  def index
    @ingredients = current_user.ingredients.includes(:ingredient_stocks)
  end
end
