FactoryBot.define do
  
  factory :admin_user,class: User do
    name { "admin_test" }
    email { "admin1@example.com" }
    password { "11111111" }
    admin{true}
  end

  factory :normal_user,class: User do
    name {'user_test'}
    email{'test2@mail.com'}
    password{'test2@mail.com'}
    admin{false}
  end
end
