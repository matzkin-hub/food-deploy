# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# 技術スタック
・rails：期限が過ぎたタスクに色をつけるようにする。ロジックの管理
・postgres：入力したTodoが消えないようにするため
・Bootstrapを使う
・Git/GitHubコードの変更履歴の保存

## 目的 : 休日を有意義にできるようなtodoアプリを作る
# 要件
・ターゲット/目的
とにかく今日やることを素早くメモしたい


## 要件定義
対象：自分一人（ログイン機能なしでスタート)
主要操作：登録、一覧、完了切り替え、削除
データ項目：内容(title), 完了フラグ(done)
見た目：１画面で完結
環境：ブラウザ

機能要件
・タスク登録
・タスク一覧表示
・タスク完了・未完了の切り替え
・タスクの削除
/時間があった時の追加機能
・自動並び替え
・一括削除

非機能要件
・レスポンスの速さ
・直感的なUI
・データの永続性


# タスクばらし

# ちょいむずポイント
・未知の技術railsを使ってアプリを開発する/Tailwind/CSSを使ってモダンなデザインにする
