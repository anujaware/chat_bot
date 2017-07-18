module ChatBot
  class Category < ActiveRecord::Base
    extend FriendlyId

    friendly_id :name, use: [:slugged, :history]

    has_many :sub_categories

    validates :name, presence: true, uniqueness: {case_sensitive: false}

    before_validation :squish_name, if: "name.present?"

    def squish_name
      self.name = name.squish.capitalize
    end

    def self.find_or_create(cat_name)
      cat_exist = Category.all.detect{|category|
        category if category.name.downcase.strip.gsub(' ', '') == cat_name.downcase.strip.gsub(' ', '')
      }
      category = cat_exist.present? ? cat_exist : Category.create(name: cat_name.strip)
    end

  end
end
