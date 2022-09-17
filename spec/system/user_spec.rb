require 'rails_helper'

RSpec.describe 'Users', type: :system do
    describe 'without login' do
        describe 'sign up' do
            context 'フォームの入力値が正常' do
                it 'ユーザーの新規作成が成功する' do
                    visit "/signup"
                    fill_in "name", with: "user001"
                    fill_in "email", with: "user001@example.com"
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
            it 'ユーザー一覧のページが表示されない'
        end
        context 'ログインしていない状態' do
            it '投稿ページへのアクセスが失敗する'
        end
    end


    describe 'ログイン後' do
        before { login_as(user) }

        describe 'ユーザー編集' do
            context 'フォームの入力値が正常' do
                it 'ユーザーの編集が成功する'
            end
            context '他ユーザーの編集ページにアクセス' do
                it '編集ページへのアクセスが失敗する'
            end
        end
        describe 'マイページ' do
            context 'タスクを作成' do
                it '新規作成したタスクが表示される'
            end
        end
    end
end