FactoryBot.define do
  factory :task do
    name {"test_name"}
    content {"test_content"}
    deadline { Time.now }
    status {"未着手"}
    priority {"高"}
  end
  factory :task_second,class: Task do
    name {"今日"}
    content {"いい天気"}
    deadline { Time.now.since(3.days) }
    status {"着手中"}
    priority {"中"}
  end
  factory :task_third,class: Task do
    name {"課題"}
    content {"終わらせたい"}
    deadline { Time.now.since(2.days) }
    status {"着手中"}
    priority {"低"}
  end
end