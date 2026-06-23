class IngredientsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy] # ログインしているユーザしかできない
  before_action :set_id, only: %i[edit update destroy] # 特定のユーザしかできないアクション
  def index
    @ingredients = Ingredient.order(created_at: :asc)
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
    @ingredient = Ingredient.find(params[:id])
  end

  private

  def ingredient_params
    params.expect(ingredient: [:name])
  end

  # application_controllerに記述する
  # ロジックとメソッド名を一致させる
  # 自分で英語を読む意識を持つ
  def set_id
    @ingredient = current_user.ingredients.find(params[:id])
  end
end
