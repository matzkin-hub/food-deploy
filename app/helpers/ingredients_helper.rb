# frozen_string_literal: true

module IngredientsHelper
  # 期限の近さを表すBootstrapのテーマカラー名(在庫なしは secondary)
  def stock_color(stock)
    case stock&.status_color
    when nil then 'secondary'
    when 'secondary' then 'success'
    else stock.status_color
    end
  end

  # 「あと 3 日」のように日数部分だけ大きく表示する
  def remaining_days_tag(stock)
    days = stock.remaining_days
    number = tag.span(days.abs, class: "display-6 fw-bolder text-#{stock_color(stock)}-emphasis")

    if days.negative?
      safe_join([number, '日超過'], ' ')
    elsif days.zero?
      tag.span('今日まで', class: "fs-5 fw-bolder text-#{stock_color(stock)}-emphasis")
    else
      safe_join(['あと', number, '日'], ' ')
    end
  end
end
