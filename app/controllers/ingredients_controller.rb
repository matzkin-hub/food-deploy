class IngredientsController < ApplicationController
  before_action :set_id, only: %i[edit update destroy show]
  before_action :authenticate_user!
  def index
    @ingredients = current_user.ingredients.includes(:ingredient_stocks)
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = current_user.ingredients.build(ingredient_params)
    if @ingredient.save
      redirect_to ingredients_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to ingredients_path
    else
      render :edit
    end
  end

  def destroy
    if @ingredient.destroy!
      redirect_to ingredient_path
    else
      render :index
    end
  end

  def show
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end

  def set_id
    @ingredient = Ingredient.find(params[:id])
  end
end
