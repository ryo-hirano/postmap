# README

# アプリ名

- FashionBlog

# 概要

ファッション・グルメ・音楽など、自分のライフスタイルを投稿できます。

# 開発状況

- 開発環境
  開発言語：
    Ruby/Ruby on Rails
  開発ツール：
    Github/Visual Studio Code

- 開発期間

  開発期間：
    10日間(4/10 ~ 4/20)
  平均作業時間：
    1日10時間

# 制作背景

プログラミングに興味を持ち始めた頃から、ファッションを投稿できるSNSを作ってみたいと思っていました。
もっとファッションを好きになる、ファッションに興味を持つきっかけを提供したく思い開発しております。
機能自体は未実装の部分が多々ございますので、引き続きアップデートしていきます。

# このサービスでできること

https://user-images.githubusercontent.com/62536923/82183948-c9648500-9921-11ea-9199-8499e176dc73.gif

https://user-images.githubusercontent.com/62536923/82183951-cc5f7580-9921-11ea-8fe5-e92bde05fe72.gif

https://user-images.githubusercontent.com/62536923/82184053-fa44ba00-9921-11ea-9359-001ca2d3f3e8.gif

## Users_table

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, default: ""|
|email|string|null: false, unique: true, index: true, default: ""|
|encrypted_password|string|null: false, default: ""|
|reset_password_token|string||
|reset_password_sent_at|datetime||
|remember_created_at|datetime||
|image|string||

## Association

- has_many :posts
- has_many :comments
- has_many :likes ,dependent: :destroy
- has_many :like_posts, through: :likes, source: :post

## Posts_table

|Column|Type|Options|
|------|----|-------|
|text|string||
|image|text||
|user_id|integer||
|likes_count|integer|default: 0, null: false|
|content|text||
|category_id|bigint||

## Association

- has_many :comments
- has_many :images
- has_many :likes, dependent: :destroy
- has_many :liking_users, through: :likes, source: :user

## Likes_table

|Column|Type|Options|
|------|----|-------|
|post_id|integer|null: false|
|user_id|integer|null: false|

## Association

- belongs_to :post, counter_cache: :likes_count
- belongs_to :user

## Images_table

|Column|Type|Options|
|------|----|-------|
|src|string||
|post_id|bigint||

## Association

- belongs_to :post

## comments_table

|Column|Type|Options|
|------|----|-------|
|text|text||
|post_id|integer||
|user_id|integer||

## Association

- belongs_to :post
- belongs_to :user

## categories_table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||

## Association
- has_many :posts
- has_ancestry

