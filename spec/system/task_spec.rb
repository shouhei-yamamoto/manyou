require 'rails_helper'
RSpec.describe "タスク管理機能",type: :system do
  let!(:user){ FactoryBot.create(:user) }
  let!(:task){ FactoryBot.create(:task,user: user) }
  let!(:task_second){ FactoryBot.create(:task_second,user: user) }
  let!(:task_third){FactoryBot.create(:task_third,user: user) }
  before do
    visit new_session_path
    fill_in "session[email]",with: "yama@gmail.com"
    fill_in "session[password]",with: "12345678"
    click_on "Log in"
  end
  #登録する
  #ここから下はいじらない・・はず
  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        # with以下はなんでもよいということでOK？
        fill_in 'task[name]', with: 'name'
        # 検索ボタンを押す
        click_on '検索'
        # botでname_title1と指定しているからhave_content以下は同じ内容である必要？
        # あいまい検索でwith以下の単語とbotで入力されたnameを比較？
        expect(page).to have_content 'name'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        # プルダウンを選択する「select」について調べてみること
        select "着手中", from: "task_status"
        click_on '検索'
        expect(page).to have_content '着手中'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'task[name]', with: 'name'
        select "着手中", from: "task_status"
        expect(page).to have_content 'name'
        expect(page).to have_content '着手中'
      end
    end
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
        fill_in 'task[name]',with: 'name_title'
        fill_in 'task[content]',with: 'test_content'
        #step3 タスクの終了期限の入力欄
        fill_in 'task[deadline]' ,with: '002022-03-15'
        select '着手中', from: "task[status]"
        select '中', from: "task[priority]"
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書
        click_on '登録する'
        # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
        expect(page).to have_content 'name_title'
        expect(page).to have_content 'test_content'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        # task = FactoryBot.create(:task, name: 'name_title1', content: 'test_content1')
        visit tasks_path
        task_test = all('.task_list')
        expect(task_test[0]).to  have_content '課題'
      end
    end
  end
  describe "新規作成機能" do
    context "タスクを新規作成した場合" do
      it "作成したタスクが表示される" do
        visit new_task_path
        fill_in "task[name]",with: "課題"
        fill_in "task[content]",with: "今日終わらせる"
        select "着手中", from: "task[status]"
        fill_in "task[deadline]",with: Time.current
        click_on "登録する"
        expect(page).to have_content "着手中"
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        @user = User.first
        FactoryBot.create(:task, name: "title1", content: "content1", deadline: "2022/1/1", status:"未着手", priority: "高", user_id: @user.id)
        visit task_path(task.id)
       end
     end
  end
end

 # describe '一覧表示機能' do
  #   context '一覧画面に遷移した場合' do
  #     it '作成済みのタスク一覧が表示される' do
  #       # テストで使用するためのタスクを作成
  #       task = FactoryBot.create(:task, name: 'task')
  #       # タスク一覧ページに遷移
  #       visit tasks_path
  #       # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
  #       # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
  #       expect(page).to have_content 'task'
  #       # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
  #     end 
  #   end
  
  #   context '終了期限でソートした場合' do
  #     it 'タスクが終了期限順に並んでいる' do   
  #       visit tasks_path
  #       click_on '終了期限でソートする' 
  #       visit tasks_path(sort_expired: "true")
  #       task_list = all('.task_list')
  #       expect(task_list[0]).to have_content 'name_title3'
  #       expect(task_list[1]).to have_content 'name_title2'
  #       expect(task_list[2]).to have_content 'name_title1'
  #     end
  #   end 
  # end