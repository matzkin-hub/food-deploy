# frozen_string_literal: true

class CreateTasklists < ActiveRecord::Migration[8.1]
  def change
    create_table :tasklists do |t|
      t.string :title, null: false
      t.integer :quantity, null: false
      t.boolean :checked, null: false, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
