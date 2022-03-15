FactoryBot.define do
  factory :user do
    name { "やま" }
    email { "yama@gmail.com" }
    password { "12345678" }
    admin { "true" }
  end

  factory :user_second,class: User do
    name { "たかはし" }
    email { "bbb@gmail.com" }
    password { "123456" }
    admin { "false" }
  end

  factory :admin_user,class: User do
    name { "テスト管理者" }
    email { "admin2@example.com" }
    password { "22222222" }
    admin { "true" }
  end
end