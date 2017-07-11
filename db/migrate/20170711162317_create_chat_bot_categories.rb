class CreateChatBotCategories < ActiveRecord::Migration
  def change
    create_table :chat_bot_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
