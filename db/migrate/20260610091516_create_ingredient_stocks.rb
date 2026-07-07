# frozen_string_literal: true

class CreateIngredientStocks < ActiveRecord::Migration[8.1]
  def change
    create_table :ingredient_stocks do |t|
      t.integer :quantity, null: false
      t.date :expire_on, null: false
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
