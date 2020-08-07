require 'rails_helper'

describe '投稿管理機能', type: :system do
        let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com', password: 'password') }
        let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com', password: 'password') }
        let!(:post_a) { FactoryBot.create(:post, text: '最初の投稿', user: user_a) }

        before '各々のログイン' do
            FactoryBot.create(:post, text: '最初の投稿', user: user_a)
            visit login_path
            fill_in 'session_email', with: login_user.email
            fill_in 'session_password', with: login_user.password
            click_button 'ログインする'
        end

        shared_examples_for 'ユーザーAが作成した投稿が表示される' do
            it { expect(page).to have_text '最初の投稿' }
        end

    describe '一覧表示機能'  do
        context 'ユーザーAがログインしているとき' do
            let(:login_user) { user_a }

            it_behaves_like 'ユーザーAが作成した投稿が表示される'         
        end

        context 'ユーザーBがログインしているとき' do
            let(:login_user) { user_b }

            
            it_behaves_like 'ユーザーAが作成した投稿が表示される'
        end
    end

    describe '詳細表示機能' do
        context 'ユーザーAがログインいているとき' do
            let(:login_user)  { user_a }

            before do
                visit post_path(post_a)
            end

            it_behaves_like 'ユーザーAが作成した投稿が表示される'
        end
    end
end