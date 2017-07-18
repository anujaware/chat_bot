module ChatBot
  class Option < ActiveRecord::Base

    belongs_to :dialog, class_name: 'ChatBot::Dialog'
    belongs_to :decision, class_name: 'ChatBot::Dialog', inverse_of: nil, primary_key: :code

    validates :name, presence: true#, if: Proc.new{|option| option.dialog.user_input_type != 'cnt'}
    validates :dialog, presence: true
    #validates :decision_id, inclusion: { in: Proc.new{|option|
    #  option.dialog.sub_category.dialogs.collect(&:code) }}, allow_blank: true#, on: :update
    validates :interval, format: { with: /\ADAY:(\d+)\z/i }, allow_blank: true
  end

  def self.deprecate!
    update_all(deprecated: true)
  end
end
