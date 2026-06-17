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

  def edit
    @ingredient = Ingredient.find(params[:ingredient_id])
    @ingredient_stock = @ingredient.ingredient_stocks.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:ingredient_id])
    @ingredient_stock = @ingredient.ingredient_stocks.find(params[:id])
    if @ingredient_stock.update(set_params)
      redirect_to ingredient_path(@ingredient)
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:ingredient_id])
    @ingredient_stock = @ingredient.ingredient_stocks.find(params[:id])
    if @ingredient_stock.destroy
      redirect_to ingredient_path(@ingredient)
    end
  end

  private

  def set_params
    params.expect(ingredient_stock: %i[quantity expire_on])
  end
end
