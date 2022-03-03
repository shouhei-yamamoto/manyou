require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # テンプレートで作成したデータを上書きしたい時
  # background do
  #   FactoryBot.create(:task, name: 'test')
  #   FactoryBot.create(:task, name: 'test2')
  #   FactoryBot.create(:second_task, name: 'test3', content: 'test_content')
  # end

  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      # 1. new_task_pathに遷移する（新規作成ページに遷移する）
      visit new_task_path
      # 2. 新規登録内容を入力する
      #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
      # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
      # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
      fill_in 'task[name]',with: 'test_name'
      fill_in 'task[content]',with: 'test_content'
      # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
       # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書
      find(".navbar-toggler-icon").click
      click_on '登録する'
      # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
      # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
      # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
      expect(page).to have_content '確認しました'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, name: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end 
    end
  end
  
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do

       end
     end
  end
end