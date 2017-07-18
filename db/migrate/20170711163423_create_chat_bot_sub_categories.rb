class CreateChatBotSubCategories < ActiveRecord::Migration
  def change
    create_table :chat_bot_sub_categories do |t|
      t.string :name, null: false
      t.string :description
      t.boolean :approval_require, default: true
      t.integer :priority, default: 1
      t.string :starts_on_key, null: false
      t.string :starts_on_val
      t.boolean :is_ready_to_schedule, default: false
      t.integer :category_id
      t.integer :initial_dialog_id
      t.string :slug, null: false, unique: true

      t.index :slug, unique: true

      t.timestamps null: false
    end
  end
end
