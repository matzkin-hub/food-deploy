# frozen_string_literal: true

# 開発用のシードデータ
#
#   bin/rails db:seed
#
# 件数は環境変数で調整できます。
#
#   USERS=5 INGREDIENTS_PER_USER=100 MAX_STOCKS_PER_INGREDIENT=8 bin/rails db:seed
#
# 1人目のユーザーは下記の固定アカウントなので、そのままログインして確認できます。
#   email: demo@example.com / password: password

DEMO_EMAIL = 'demo@example.com'
DEMO_PASSWORD = 'password'

INGREDIENT_NAMES = %w[
  トマト きゅうり なす にんじん じゃがいも たまねぎ キャベツ レタス ほうれん草 ブロッコリー
  ピーマン かぼちゃ 大根 長ねぎ しめじ えのき 椎茸 さつまいも ごぼう れんこん
  豚バラ肉 鶏むね肉 鶏もも肉 牛こま切れ肉 合いびき肉 ベーコン ウインナー ハム 鮭 さば
  まぐろ えび いか あさり 卵 牛乳 ヨーグルト チーズ バター 豆腐
  納豆 油揚げ こんにゃく 食パン うどん そば パスタ 味噌 醤油 ケチャップ
  マヨネーズ オリーブオイル りんご バナナ みかん いちご ぶどう キウイ アボカド レモン
].freeze

# 一番手前の賞味期限の傾向。IngredientStock#status_color の4色がひと通り並ぶように散らします。
EXPIRE_RANGES = [
  -7..0,  # 期限切れ〜今日（danger）
  1..1,   # 明日（danger）
  2..4,   # warning
  5..7,   # primary
  8..60   # secondary
].freeze

IMAGE_COLORS = %w[#e57373 #81c784 #64b5f6 #ffb74d #ba68c8 #4db6ac #f06292 #a1887f].freeze

users_count = ENV.fetch('USERS', 3).to_i
ingredients_per_user = ENV.fetch('INGREDIENTS_PER_USER', 60).to_i
max_stocks = ENV.fetch('MAX_STOCKS_PER_INGREDIENT', 5).to_i

# 名前が足りなくなったら「トマト 2」のように連番を付けて使い回します。
def ingredient_name(index)
  base = INGREDIENT_NAMES[index % INGREDIENT_NAMES.size]
  round = index / INGREDIENT_NAMES.size
  round.zero? ? base : "#{base} #{round + 1}"
end

# 食材カードの見た目を確認できるように、ダミー画像（SVG）を作ります。
def placeholder_image(name, index)
  color = IMAGE_COLORS[index % IMAGE_COLORS.size]
  svg = <<~SVG
    <svg xmlns="http://www.w3.org/2000/svg" width="400" height="300" viewBox="0 0 400 300">
      <rect width="400" height="300" fill="#{color}"/>
      <text x="200" y="165" fill="#ffffff" font-size="48" font-family="sans-serif" text-anchor="middle">#{ERB::Util.html_escape(name)}</text>
    </svg>
  SVG
  { io: StringIO.new(svg), filename: "ingredient-#{index}.svg", content_type: 'image/svg+xml' }
end

puts '既存データを削除しています...'
User.destroy_all

ActiveRecord::Base.transaction do
  users_count.times do |user_index|
    user = User.create!(
      email: user_index.zero? ? DEMO_EMAIL : Faker::Internet.unique.email,
      password: DEMO_PASSWORD
    )

    ingredients_per_user.times do |index|
      name = ingredient_name(index)
      ingredient = user.ingredients.create!(name: name)
      # 3件に1件は画像なしにして、画像あり・なし両方のカードを確認できるようにします。
      ingredient.image.attach(placeholder_image(name, index)) unless (index % 3).zero?

      # 10件に1件は在庫なし（一覧の最後に並びます）。
      next if (index % 10) == 9

      # 一番手前の賞味期限でカードの色が決まるので、食材ごとに傾向を決めて色を散らします。
      base_offset = EXPIRE_RANGES.sample.to_a.sample
      rand(1..max_stocks).times do |stock_index|
        offset = stock_index.zero? ? base_offset : base_offset + rand(1..30)
        ingredient.ingredient_stocks.create!(
          expire_on: Date.current + offset.days,
          quantity: rand(1..20)
        )
      end
    end

    puts "#{user.email} に食材 #{ingredients_per_user} 件を作成しました"
  end
end

puts "ユーザー: #{User.count} / 食材: #{Ingredient.count} / 在庫: #{IngredientStock.count}"
puts "ログイン: #{DEMO_EMAIL} / #{DEMO_PASSWORD}"
