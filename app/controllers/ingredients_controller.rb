class IngredientsController < ApplicationController
  before_action :require_correct_user, only: %i[edit update destroy] # 特定のユーザしかできないアクション
  before_action :authenticate_user!, only: %i[new create edit update destroy] # ログインしているユーザしかできない
  def index
    @ingredients = Ingredient.all
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
  def require_correct_user
    @ingredient = current_user.ingredients.find(params[:id])
  end
end
