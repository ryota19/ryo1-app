require 'rails_helper'

feature 'ログイン機能', type: :system do

    background do  
        user_a = FactoryBot.create(:user, name: 'user_a', email: 'a@example.com', password: 'password')
        FactoryBot.create(:post, text: '最初の投稿', user: user_a)

        visit root_path
            fill_in 'session_email', with: 'a@example.com'
            fill_in 'session_password', with: 'password'
            click_button 'ログイン' 
    end    


    context 'ログイン' do
        scenario 'ログイン'  do
            expect(page).to have_content 'ログインしました'
        end
    end
    context 'ログアウト' do
        scenario 'ログアウト' do
            click_on 'logout'
            expect(page).to have_content 'ログアウトしました'
        end
    end
   
    context 'アカウント編集' do
        scenario 'アカウント編集' do
            visit users_path
            click_on '編集'
            fill_in 'session_password2', with: 'password'
            fill_in 'session_passwordconfir', with: 'password'
            click_button '更新する'
            
            expect(page).to have_content 'ユーザーを更新しました'
        end
    end

    context 'アカウント削除' do
        scenario '削除' do
            visit users_path
            click_on 'user_a'
            click_on '削除'
            
            expect(page).to have_content 'ユーザーを削除しました'
        end
    end
end 
