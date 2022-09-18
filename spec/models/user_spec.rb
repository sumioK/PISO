require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'valid' do
        it "正常にユーザー登録が可能" do
            user = User.new(
                name: "Jack",
                email: "jhon@example.com",
                password: "password"
            )
            user.save
            expect(user).to be_valid
        end
        it "ユーザー名が空の場合ユーザー登録ができない" do
            user = User.new(
                name: nil
            )
            expect(user).to be_invalid
            expect(user.errors[:name]).to include("can't be blank")
        end
        it "メールアドレスが空の場合ユーザー登録ができない" do
            user = User.new(
                email: nil
            )
            expect(user).to be_invalid
            expect(user.errors[:name]).to include("can't be blank")
        end
        it "メールアドレスに＠が含まれない場合ユーザー登録できない" do
            user = User.new(
                name: "Jack",
                email: "jackexample.com",
                password: "password"
            )
            expect(user).to be_invalid
        end
        it "重複したメールアドレスが入力された場合ユーザー登録ができない" do
            User.create(
                name: "Jack",
                email: "jack@example.com",
                password: "password"
            )
            user = User.new(
                name: "Jhoe",
                email: "jack@example.com",
                password: "password"
            )
            user.valid?
            expect(user.errors[:email]).to include("has already been taken")
        end
    end
    describe 'check true value' do
        it "正常な名前が入力された場合" do
            user = User.create(
                name: "Jack",
                email: "jack@example.com",
                password: "password",
                introduction: "test"
            )
            expect(user.name).to eq "Jack"
        end
        it "正常なメールアドレスが入力された場合" do
            user = User.create(
                name: "Jack",
                email: "jack@example.com",
                password: "password",
                introduction: "test"
            )
            expect(user.name).to eq "Jack"
        end
        it "introductionが正しく入力された場合" do
            user = User.create(
                name: "Jack",
                email: "jack@example.com",
                password: "password",
                introduction: "test"
            )
            expect(user.name).to eq "Jack"
        end
        it "passwordが正しく入力された場合" do
            user = User.create(
                name: "Jack",
                email: "jack@example.com",
                password: "password",
                introduction: "test"
            )
            expect(user.name).to eq "Jack"
        end
    end
end