# frozen_string_literal: true

# ブラウザを閉じてもセッションが切れにくいように、有効期限付きのcookieにする
Rails.application.config.session_store :cookie_store, key: '_matzkin_food_management_app_session', expire_after: 3.months
