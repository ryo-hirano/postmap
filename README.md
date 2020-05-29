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

![categories](https://user-images.githubusercontent.com/62536923/83236210-1a039a00-a1ce-11ea-8553-d0f969fee465.gif)

![post](https://user-images.githubusercontent.com/62536923/83236279-37d0ff00-a1ce-11ea-9e47-aca6d258d057.gif)

![ranking](https://user-images.githubusercontent.com/62536923/83236374-6353e980-a1ce-11ea-95c6-4250909facb4.gif)

![show-posts](https://user-images.githubusercontent.com/62536923/83236428-79fa4080-a1ce-11ea-8861-da5ab17f2023.gif)

![top-slider](https://user-images.githubusercontent.com/62536923/83236546-a3b36780-a1ce-11ea-8bf6-d49f4c6a024d.gif)

![edit-prof](https://user-images.githubusercontent.com/62536923/83236609-c04f9f80-a1ce-11ea-9ec4-5f07f90b9896.gif)

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
|introduction|text||

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

