# frozen_string_literal: true

module ApplicationHelper
  # ポップな見た目のボタン(太い枠線 + 丸み + 影)用のクラス
  def pop_btn(variant, extra = nil)
    ["btn btn-#{variant} rounded-pill border-3 border-dark shadow-sm fw-bold", extra].compact.join(' ')
  end

  # 太い枠線 + 大きな角丸 + 影のカード用クラス
  def pop_card(extra = nil)
    ['card border-3 border-dark rounded-4 shadow', extra].compact.join(' ')
  end
end
