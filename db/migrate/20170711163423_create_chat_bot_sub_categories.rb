class CreateChatBotSubCategories < ActiveRecord::Migration
  def change
    create_table :chat_bot_sub_categories do |t|
      t.string :name
      t.string :description
      t.boolean :approval_require
      t.integer :priority
      t.string :starts_on_key
      t.string :starts_on_val
      t.boolean :is_ready_to_schedule
      t.integer :category_id
      t.integer :initial_dialog_id

      t.timestamps null: false
    end
  end
end
