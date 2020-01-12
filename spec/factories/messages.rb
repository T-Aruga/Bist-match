FactoryBot.define do
  factory :message do
    content { 'aaa' }
    user_id { 1 }
    conversation_id { 1 }
  end
end
