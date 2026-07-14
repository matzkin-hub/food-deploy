# frozen_string_literal: true

class IngredientsController < ApplicationController
  before_action :set_id, only: %i[edit update destroy] # 特定のユーザしかできないアクション
  def index
    @ingredients = current_user.ingredients.left_joins(:ingredient_stocks).includes(:ingredient_stocks).group('ingredients.id').order('MIN(ingredient_stocks.expire_on) ASC NULLS LAST').page(params[:page]).per(8)
  end

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

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to ingredient_path(@ingredient), notice: '食材名の変更に成功しました'
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

  def show
    @ingredient = Ingredient.find(params[:id])
    redirect_to ingredients_path and return unless @ingredient.user == current_user
  end

  private

  def ingredient_params
    params.expect(ingredient: %i[name image])
  end

  # application_controllerに記述する
  # ロジックとメソッド名を一致させる
  # 自分で英語を読む意識を持つ
  def set_id
    @ingredient = current_user.ingredients.find(params[:id])
  end
end
