class CreateChatBotOptions < ActiveRecord::Migration
  def change
    create_table :chat_bot_options do |t|
      t.string :name
      t.string :interval
      t.boolean :deprecated
      t.integer :dialog_id
      t.integer :decision_id

      t.timestamps null: false
    end
  end
end
