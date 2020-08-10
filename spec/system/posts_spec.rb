require 'rails_helper'

describe '投稿管理機能', type: :system do
        let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com', password: 'password') }
        let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com', password: 'password') }
        let!(:post_a) { FactoryBot.create(:post, text: '最初の投稿', user: user_a) }

        before '各々のログイン' do
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

    describe '新規投稿機能' do
        let(:login_user) { user_a }

        before do
            visit new_post_path
            fill_in 'text_area', with: post_text
            click_button '投稿'
        end

        context '新規作成画面で投稿を入力したとき' do
            let(:post_text) { '新規作成テストを書く' }

            it '正常に登録される' do
                expect(page).to have_selector '.flash', text: '投稿を作成しました'
            end
        end

        context '新規作成画面で名称を入力しなかったとき' do
            let(:post_text) { '' }

            it 'エラーとなる' do
                expect(page).to have_text "Text can't be blank"
            end
        end
    end

    describe '投稿更新機能' do
        let(:login_user) { user_a }

        before do
            visit edit_post_path(post_a)
            fill_in 'text_area', with: post_text
            click_button '投稿'
        end
        context '新規作成画面で投稿を入力したとき' do
            let(:post_text) { '新規作成テストを書く' }

            it '正常に登録される' do
                expect(page).to have_selector '.flash', text: '投稿を編集しました'
            end
        end
    end

    describe '投稿削除機能' do
        let(:login_user) { user_a }
        before do
            visit post_path(post_a)
            click_on '削除'
        end

        context '投稿削除' do
            it '投稿が削除される' do
                expect(page).to have_text '投稿を削除しました'
            end
        end
    end
end