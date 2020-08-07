require 'rails_helper'

describe '投稿管理機能', type: :system do
    describe '一覧表示機能' do
        before do
            user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com', password: 'password')
            FactoryBot.create(:post, text: '最初の投稿', user: user_a)
        end

        context 'ユーザーAがログインしているとき' do

            
            before do
                visit login_path
                fill_in 'session_email', with: 'a@example.com'
                fill_in 'session_password', with: 'password'
                click_button 'ログインする'
            end
    
            it 'ユーザーが作成した投稿が表示される' do
                expect(page).to have_text '最初の投稿'
            end
        end

        context 'ユーザーBがログインしているとき' do
            before do
                FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com', password: 'password')
                visit login_path
                fill_in 'session_email', with: 'b@example.com'
                fill_in 'session_password', with: 'password'
                click_button 'ログインする'
            end

            it 'ユーザーAが作成したタスクが表示される' do
                expect(page).to have_text '最初の投稿'
            end
        end
    end
end