class CreateChatBotDialogs < ActiveRecord::Migration
  def change
    create_table :chat_bot_dialogs do |t|
      t.string :code
      t.string :message
      t.string :user_input_type
      t.string :message_type
      t.integer :repeat_limit
      t.integer :sub_category_id
      t.string :slug, :null => false

      t.index :slug

      t.timestamps null: false
    end
  end
end
