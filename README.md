# README

## 1.アプリケーション名
PISO

## 2.アプリケーション概要
ペットの画像を共有するアプリケーションです。  
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
* UNICOEN
* Nginx
* JavaScript
* Docker/Docker-compose
* CircleCi
* Capistrano
* AWS  
    * VPC
    * EC2
    * Route53
    * RDS

## 4.インフラ構成  
### CI/CD  
* Githubへのpush時、Circleciにより自動でRspecが実行されます。  
* Rspecが成功した場合、CapistranoによりEC2サーバーへの自動デプロイが実行されます。

## 5.機能一覧
* ユーザー登録、ログイン機能(暗号化にbcryptｗ使用)
* 投稿機能
* フォロー機能
* コメント機能
* いいね機能
* 検索機能

## 6.テスト
* model Spec
* rquest Spec
* system Spec