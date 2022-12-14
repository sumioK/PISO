require 'rails_helper'

RSpec.describe 'Users', type: :system do
    describe 'ログインしていない状態' do
        describe '新規登録' do
            context 'フォームの入力値が正常' do
                it 'ユーザーの新規作成が成功する' do
                    visit "/signup"
                    fill_in "name", with: "user001"
                    fill_in "email", with: "user002@example.com"
                    fill_in "password", with: "password"
                    fill_in "password2", with: "password"
                    click_button "登録"
                    expect(page).to have_content "ユーザー登録に成功しました"
                    
                end
            end
            context 'メールアドレスが未入力' do
                it 'ユーザーの新規作成が失敗する' do
                    visit "/signup"
                    fill_in "name", with:"user001"
                    fill_in "name", with: "user001"
                    fill_in "email", with: ""
                    fill_in "password", with: "password"
                    fill_in "password2", with: "password"
                    click_button "登録"
                    expect(current_path).to eq "/signup"
                end
            end
            context '登録済のメールアドレスを使用' do
                it 'ユーザーの新規作成が失敗する' do
                    user = User.create(
                        name: "user001",
                        email: "user001@example.com",
                        password: "password"
                    )
                    visit "/signup"
                    fill_in "name", with:"user001"
                    fill_in "name", with: "user001"
                    fill_in "email", with: "user001@example.com"
                    fill_in "password", with: "password"
                    fill_in "password2", with: "password"
                    click_button "登録"
                    expect(current_path).to eq "/signup"
                end
            end
        end
    end
    describe 'マイページ' do
        context 'ログインしていない状態' do
            it 'マイページへのアクセスが失敗する' do
                user = User.create(
                    name: "user001",
                    email: "user001@example.com",
                    password: "password"
                )
                visit "/users/#{user.id}"
                expect(current_path).to eq "/login"
                expect(page).to have_content "ログインが必要です"
            end
        end
        context 'ログインしていない状態' do
            it 'ユーザー一覧のページが表示されない' do
                visit "/users/index"
                expect(current_path).to eq "/login"
                expect(page).to have_content "ログインが必要です"
            end
        end
    end


    describe 'ログイン後' do
        before do
            user = User.create(
                id:3,
                name: "user003",
                email: "user003@example.com",
                password_digest: "password"
            )
            user1 = User.create(
                id:4,
                name: "user004",
                email: "user004@example.com",
                password_digest: "password" 
            )
            post = Post.create(
                id:1,
                user_id:3,
                image:"sample.jpg"
            )
            post1 = Post.create(
                id:2,
                user_id:3,
                image:"sample1.jpg"
            )
            visit "/login"
            fill_in "email", with: "user003@example.com"
            fill_in "password", with: "password"
            click_button "ログイン"
        end
        describe 'ページアクセス' do
            context 'ログインページにアクセスする' do
                it 'アクセスに失敗する' do
                    visit "/login"
                    expect(page).to have_content "すでにログインしています"
                end
            end
            context '新規登録ページにアクセスする' do
                it 'アクセスに失敗する' do
                    visit "/signup"
                    expect(page).to have_content "すでにログインしています"
                end
            end
            context 'ユーザーページへアクセス' do
                it 'ユーザー一覧が表示される' do
                    visit "/users/index"
                    expect(current_path).to eq "/users/index"
                end
            end
            context '投稿画面にアクセスする' do
                it '投稿画面が表示される' do
                    visit "/posts/new"
                    expect(current_path).to eq "/posts/new"
                end
            end
            context '投稿詳細画面にアクセスする' do
                it 'アクセスに成功する' do
                    visit "/posts/1"
                    expect(current_path).to eq "/posts/1"
                end
            end
            context 'ユーザー画面にアクセスする' do
                it 'ユーザー情報が表示される' do
                    visit "/users/3"
                    expect(current_path).to eq "/users/3"
                end
            end
            context 'ユーザー編集画面にアクセスする' do
                it 'ユーザー編集画面が表示される' do
                    visit "/users/3/edit"
                    expect(current_path).to eq "/users/3/edit"
                end
            end
            context '他人のユーザー画面にアクセスする' do
                it 'ユーザー画面が表示される' do
                    visit "/users/4"
                    expect(current_path).to eq "/users/4"
                end
            end
        end
        context '他人のユーザー編集画面にアクセスする' do
            it 'アクセスできない' do
                visit "/users/4/edit"
                expect(page).to have_content "権限がありません"
            end
        end
        describe 'POST' do
            context '新規投稿' do
                it '写真・文章をともに選択すると投稿に成功する' do
                    visit "/posts/new"
                    attach_file("post-img", "#{Rails.root}/spec/sample.jpg", visible: true)
                    fill_in "content", with: "test sentence"
                    click_button "投稿"
                    expect(page).to have_content "test sentence"
                    expect(current_path).to eq "/posts/index"
                end 
                it '画像のみの投稿が成功する' do
                    visit "/posts/new"
                    attach_file("post-img", "#{Rails.root}/spec/sample.jpg", visible: true)
                    click_button "投稿"
                    expect(current_path).to eq "/posts/index"
                end
                
                it '画像がない投稿が失敗する' do
                    visit "/posts/new"
                    fill_in "content", with: "test sentence"
                    click_button "投稿"
                    expect(page).to have_content "画像が選択されていません"
                    expect(current_path).to eq "/posts/new"
                end
            end
            context '投稿編集' do
                before do
                    visit "/posts/1/edit"
                end
                it 'contentのみの編集が成功する' do
                    fill_in "content", with: "test content"
                    click_button "更新"
                    expect(current_path).to eq "/posts/1"
                    expect(page).to have_content "test content"
                    expect(page).to have_content "編集に成功しました"
                end
                it '画像のみの編集が成功する' do
                    attach_file("post-img",  "#{Rails.root}/spec/sample1.jpg", visible: true)
                    click_button "更新"
                    expect(current_path).to eq "/posts/1"
                    expect(page).to have_content "編集に成功しました"
                end
                it '画像・contentの編集が成功する' do
                    attach_file("post-img",  "#{Rails.root}/spec/sample1.jpg", visible: true)
                    fill_in "content", with: "test content"
                    click_button "更新"
                    expect(current_path).to eq "/posts/1"
                    expect(page).to have_content "test content"
                    expect(page).to have_content "編集に成功しました"
                end
            end
            context 'ユーザー編集' do
                before do
                    visit "/users/3/edit"
                end
                it 'ユーザー名が空の場合更新に失敗する' do
                    fill_in "name", with: nil
                    click_button "更新"
                    expect(current_path).to eq "/users/3/edit"
                    expect(page).to have_content "更新できませんでした"
                end
                it 'メールアドレスが不正な場合更新に失敗する' do
                    fill_in "email", with: "test.com"
                    click_button "更新"
                    expect(current_path).to eq "/users/3/edit"
                    expect(page).to have_content "更新できませんでした"
                end
                it '何も入力していない更新が成功する' do
                    click_button "更新"
                    expect(current_path).to eq "/users/3"
                    expect(page).to have_content "編集が完了しました"
                end
                it '画像を選択しての更新が成功する' do
                    attach_file("profiel_image",  "#{Rails.root}/spec/sample.jpg")
                    click_button "更新"
                    expect(current_path).to eq "/users/3"
                    expect(page).to have_content "編集が完了しました"
                end
                it 'プロフィールが空の場合も投稿に成功する' do
                    fill_in "introduction", with:nil
                    click_button "更新"
                    expect(current_path).to eq "/users/3"
                    expect(page).to have_content "編集が完了しました"
                end
            end

        end
    end
end