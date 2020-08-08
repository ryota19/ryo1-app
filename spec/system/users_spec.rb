require 'rails_helper'

feature 'ログイン機能', type: :system do

    background do
        User.create!(name: 'user_a', email: 'a@example.com', password: 'password')   
    end    

    scenario 'ログイン'  do
        visit root_path
        fill_in 'session_email', with: 'a@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'ログイン'

        expect(page).to have_content 'ログインしました'
    end

    scenario 'ログアウト' do
        visit root_path
        fill_in 'session_email', with: 'a@example.com'
        fill_in 'session_password', with: 'password'
        click_button 'ログイン'
        click_on 'logout'

        expect(page).to have_content 'ログアウトしました'
    end
end