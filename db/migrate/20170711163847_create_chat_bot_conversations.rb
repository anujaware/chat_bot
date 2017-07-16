class CreateChatBotConversations < ActiveRecord::Migration
  def change
    create_table :chat_bot_conversations do |t|
      t.string :aasm_state
      t.integer :viewed_count
      t.datetime :scheduled_at
      t.integer :priority
      t.integer :sub_category_id
      t.integer :dialog_id, null: false
      t.integer :created_for_id, null: false
      t.integer :option_id

      t.index :dialog_id
      t.index :created_for_id

      t.timestamps null: false
    end
  end
end
