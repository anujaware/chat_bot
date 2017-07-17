FactoryGirl.define do
  factory :chat_bot_category, class: 'ChatBot::Category' do
    name { FFaker::Lorem.word }
  end
end
