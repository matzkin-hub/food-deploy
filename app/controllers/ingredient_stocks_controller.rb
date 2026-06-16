class IngredientStocksController < ApplicationController
  def new
    @ingredient = Ingredient.find(params[:ingredient_id])
    @ingredient_stock = @ingredient.ingredient_stocks.build
  end

  def create
    @ingredient = Ingredient.find(params[:ingredient_id])
    @ingredient_stock = @ingredient.ingredient_stocks.build(set_params)
    if @ingredient_stock.save
      redirect_to ingredient_path(@ingredient), notice: '成功です'
    else
      flash.now[:alert] = '個数を入力してください'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_params
    params.expect(ingredient_stock: %i[quantity expire_on])
  end
end
