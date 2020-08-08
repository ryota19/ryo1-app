require 'rails_helper'

feature 'ログイン機能' do
    background do
        User.create!(name: 'user_a', email: 'a@example.com', password: 'password' )
    end

    scenario 'ログインする' do
        visit root_path
        fill_in 'session_email', with: 'a@example.com'
        fill_in 'session_password', with: 'password'
        click_on 'ログイン'

        expect(page).to have_content 'ログインしました'
    end

    scenario 'ログアウト' do
       visit root_path
       fill_in 'session_email', with: 'a@example.com'
       fill_in 'session_password', with: 'password'
       click_on 'ログイン'
       click_on 'logout'

       expect(page).to have_content 'ログアウトしました'
    end
end

