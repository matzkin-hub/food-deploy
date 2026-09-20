# frozen_string_literal: true

class IngredientStocksController < ApplicationController
  before_action :set_id, only: %i[new create edit update destroy]
  before_action :set_ingredient_stock, only: %i[edit update destroy]
  def new
    @ingredient_stock = @ingredient.ingredient_stocks.build
  end

  def create
    @ingredient_stock = @ingredient.ingredient_stocks.build(set_params)
    if @ingredient_stock.save
      redirect_to ingredient_path(@ingredient), notice: '在庫の登録に成功しました'
    else
      flash.now[:alert] = '在庫の登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @ingredient_stock.update(set_params)
      redirect_to ingredient_path(@ingredient), notice: '在庫の変更に成功しました'
    else
      flash.now[:alert] = '在庫の変更に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @ingredient_stock.destroy
      redirect_to ingredient_path(@ingredient), notice: '在庫を削除しました'
    else
      redirect_to ingredient_path(@ingredient), alert: '在庫の削除に失敗しました'
    end
  end

  private

  def set_params
    params.expect(ingredient_stock: %i[quantity expire_on])
  end

  def set_id
    @ingredient = current_user.ingredients.find(params[:ingredient_id])
  end

  def set_ingredient_stock
    @ingredient_stock = @ingredient.ingredient_stocks.find(params[:id])
  end
end
