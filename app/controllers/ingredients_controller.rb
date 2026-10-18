# frozen_string_literal: true

class IngredientsController < ApplicationController
  before_action :set_id, only: %i[show edit update destroy]
  def index
    @ingredients = Ingredient.left_joins(:ingredient_stocks).includes(:ingredient_stocks).group('ingredients.id').order('MIN(ingredient_stocks.expire_on) ASC NULLS LAST').page(params[:page]).per(12)
  end

  def show; end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = current_user.ingredients.build(ingredient_params)
    if @ingredient.save
      redirect_to ingredients_path, notice: '食材の登録に成功しました'
    else
      flash.now[:alert] = '食材の登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to ingredients_path, notice: '食材名の変更に成功しました'
    else
      render :edit
    end
  end

  def destroy
    if @ingredient.destroy!
      redirect_to ingredients_path, notice: '食材一覧から食材を削除しました'
    else
      render :index
    end
  end

  private

  def ingredient_params
    params.expect(ingredient: %i[name image])
  end

  def set_id
    @ingredient = Ingredient.find(params[:id])
  end
end
