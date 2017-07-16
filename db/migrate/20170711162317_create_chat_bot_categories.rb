class CreateChatBotCategories < ActiveRecord::Migration
  def change
    create_table :chat_bot_categories do |t|
      t.string :name
      t.string :slug, :null => false, unique: true
      t.index :slug, unique: true

      t.timestamps null: false
    end
  end
end
