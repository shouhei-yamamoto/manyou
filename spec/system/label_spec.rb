require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user_id: user.id) }
  let!(:lebel) { FactoryBot.create(:label) }
  let!(:lebel2) { FactoryBot.create(:label2) }
  before do
    visit new_session_path
    fill_in "session[email]",with: "yama@gmail.com"
    fill_in "session[password]",with: "12345678"
    click_on "Log in"
    visit tasks_path
  end
  describe 'ラベル登録機能' do
    context 'タスクを新規作成時、ラベルを選択した場合' do
      it 'ラベルが登録される' do
        visit new_task_path
        fill_in 'task_name',with: 'test_name'
        fill_in 'task_content',with: 'test_content'
        fill_in 'task_deadline' ,with: '002020-10-11'
        select '着手中', from: "task[status]"
        select '中', from: "task[priority]"
        
        check 'label'
        
        click_on '登録する'
        click_on 'Back'
        expect(page).to have_content( 'label')
      end
    end

    context 'ラベルを複数登録した場合' do
      it '複数のラベルが登録される' do
        visit new_task_path
        fill_in 'task_name', with: 'test_name'
        fill_in 'task_content', with: 'test_content'
        fill_in 'task_deadline' ,with: '002020-10-11'
        check 'label'
        check 'label2'
        click_on '登録する'
        click_on 'Back'
        expect(page).to have_content 'label'
        expect(page).to have_content 'label2'
      end
    end
  end

  describe 'ラベル編集機能' do
    context 'タスク編集時にラベルの選択を変更した場合' do
      it '変更したラベルに変わる' do
        click_on '編集', match: :first
        check 'label'
        check 'label2'
        click_on '更新する'
        expect(page).to have_content 'label'
        expect(page).to have_content 'label2'
      end
    end
  end

  describe 'ラベル詳細表示機能' do
    context 'ラベルを登録した場合' do
      it '詳細画面で登録したラベル一覧が表示される' do
        click_on '編集', match: :first
        check 'label'
        check 'label2'
        click_on '更新する'
        click_on 'Back'
        click_on '詳細',  match: :first
        expect(page).to have_content 'label'
        expect(page).to have_content 'label2'
      end
    end
  end

  describe 'ラベル検索機能' do
    context '一覧画面でラベルを検索した場合' do
      it '検索に引っかかるタスクが表示される' do
        visit new_task_path
        fill_in 'task_name', with: 'test_name'
        fill_in 'task_content', with: 'test_content'
        fill_in 'task_deadline' ,with: '002020-10-11'
        check 'label'
        click_on '登録する'
        click_on 'Back'
        select 'label', from: 'label_id'
        click_on 'ラベル検索'
        expect(page).to have_content 'label'
      end
    end
  end
end