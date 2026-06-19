class IngredientStocksController < ApplicationController
  before_action :require_correct_user, only: %i[new create edit update destroy]
  def new
    @ingredient_stock = @ingredient.ingredient_stocks.build
  end

  def create
    @ingredient_stock = @ingredient.ingredient_stocks.build(set_params)
    if @ingredient_stock.save
      redirect_to ingredient_path(@ingredient), notice: '成功です'
    else
      flash.now[:alert] = '個数を入力してください'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @ingredient_stock = @ingredient.ingredient_stocks.find(params[:id])
  end

  def update
    @ingredient_stock = @ingredient.ingredient_stocks.find(params[:id])
    if @ingredient_stock.update(set_params)
      redirect_to ingredient_path(@ingredient)
    end
  end

  def destroy
    @ingredient_stock = @ingredient.ingredient_stocks.find(params[:id])
    if @ingredient_stock.destroy
      redirect_to ingredient_path(@ingredient)
    end
  end

  private

  def set_params
    params.expect(ingredient_stock: %i[quantity expire_on])
  end

  # application_controllerに記述する
  # ロジックとメソッド名を一致させる
  # 自分で英語を読む意識を持つ
  def require_correct_user
    @ingredient = current_user.ingredients.find(params[:ingredient_id])
  end
end
