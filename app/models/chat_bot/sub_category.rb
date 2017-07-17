module ChatBot
  class SubCategory < ActiveRecord::Base
    extend FriendlyId

    friendly_id :name, use: [:slugged, :history]

    AFTER_DIALOG = 'after_dialog'.freeze
    AFTER_DAYS = 'after_days'.freeze
    IMMEIDIATE = 'immediate'.freeze
    STARTS_ON = [AFTER_DIALOG, AFTER_DAYS, IMMEIDIATE].freeze

    belongs_to :category

    validates :name, presence: true, uniqueness: { scope: :category_id }
    validates :priority, presence: true, numericality: { only_integer: true,
                                                         less_than: 11,
                                                         greater_than: 0}
    validates :category, presence: true
    validates :starts_on_key, inclusion: { in: STARTS_ON }

    before_validation :set_default_starts_on, on: :create

    private

    def set_default_starts_on
      self.starts_on_key = IMMEIDIATE if starts_on_key.blank?
    end
  end
end
