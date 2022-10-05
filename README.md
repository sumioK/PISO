# README

## 1.アプリケーション名
PISO

## 2.アプリケーション概要
ペットの画像を共有するアプリケーションです.
### URL  
https://piso-animals.com  
### テスト用アカウント  
メールアドレス:pisotestuser@example.com  
パスワード:pisotest1234

## 3.使用技術
* Ruby 3.1.2
* Ruby on Rails 7.0.4
* RSpec
* MySQL
* Puma
* Nginx
* JavaScript
* Docker/Docker-compose
* AWS  
    * VPC
    * EC2
    * Route53
    * RDS

## 4.機能一覧
* ユーザー登録,ログイン機能(暗号化にbcryptを使用)
* 投稿機能
* フォロー機能
* コメント機能
* いいね機能
* 検索機能
* 無限スクロール機能(kaminari,jscroll使用)

## 5.テスト
* model Spec
* rquest Spec
* system Spec