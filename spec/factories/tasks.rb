FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します
  factory :task do
    name { 'name_title1' }
    content { 'test_content1' }
    # user { 'test_user1' }
  end

  factory :second_task, class: Task do
    name { 'name_title2' }
    content { 'test_content2' }
    # user { 'test_user2' }
  end
end