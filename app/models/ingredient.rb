# frozen_string_literal: true

class Ingredient < ApplicationRecord
  belongs_to :user
  has_many :ingredient_stocks, dependent: :destroy
  has_one_attached :image
  validates :name, presence: true

  # 一覧のカード表示用。ingredient_stocksが読み込み済みなら追加のクエリは発生しない
  def total_quantity
    ingredient_stocks.sum(&:quantity)
  end

  def earliest_stock
    ingredient_stocks.min_by(&:expire_on)
  end
end
