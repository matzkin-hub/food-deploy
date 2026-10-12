# frozen_string_literal: true

class IngredientStock < ApplicationRecord
  belongs_to :ingredient
  validates :expire_on, presence: true
  validates :quantity, presence: true

  validates :quantity, numericality: {
    greater_than_or_equal_to: 0
  }

  def status_color
    if expire_on <= 1.day.from_now.to_date
      'danger'
    elsif expire_on <= 4.days.from_now.to_date
      'warning'
    elsif expire_on <= 7.days.from_now.to_date
      'primary'
    else
      'secondary'
    end
  end

  def remaining_days
    (expire_on - Date.current).to_i
  end

  def remaining_days_label
    days = remaining_days
    if days.negative?
      "#{days.abs}日超過"
    elsif days.zero?
      '今日まで'
    else
      "あと#{days}日"
    end
  end
end
