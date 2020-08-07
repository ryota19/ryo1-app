require 'rails_helper'

describe '投稿管理機能', type: :system do
    describe '一覧表示機能'  do
        let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com', password: 'password') }
        let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com', password: 'password') }

        before '各々のログイン' do
            FactoryBot.create(:post, text: '最初の投稿', user: user_a)
            visit login_path
            fill_in 'session_email', with: login_user.email
            fill_in 'session_password', with: login_user.password
            click_button 'ログインする'
        end

        context 'ユーザーAがログインしているとき' do
            let(:login_user) { user_a }

            it 'ユーザーAが作成した投稿が表示される' do
                expect(page).to have_text '最初の投稿'
            end
        end

        context 'ユーザーBがログインしているとき' do
            let(:login_user) { user_b }

            it 'ユーザーAが作成した投稿が表示されない' do
                expect(page).to have_text '最初の投稿'
            end
        end
    end
end