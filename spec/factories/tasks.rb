FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します
  factory :task do
    name { 'name_title1' }
    content { 'test_content1' }
    deadline { DateTime.now }
    status {'着手中'}
  end

  factory :second_task, class: Task do
    name { 'name_title2' }
    content { 'test_content2' }
    deadline { DateTime.now + 1 }
    status {'未着手'}
  end

  factory :third_task, class: Task do
    name { 'name_title3' }
    content { 'test_content3' }
    deadline { DateTime.now + 5 }
    status {'完了'}
  end    
end