require 'rails_helper'

RSpec.describe ChatBot::SubCategory, type: :model do
  SubCategory = ChatBot::SubCategory

  context 'Validation' do
    it { should validate_presence_of(:name) }
    #it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:category_id) }
    it { should validate_presence_of(:category) }
    it { should validate_numericality_of(:priority).only_integer.is_less_than(11).is_greater_than(0) }
    it { should validate_inclusion_of(:starts_on_key).in_array(SubCategory::STARTS_ON) }

    it 'uniqueness' do
      #create(:sub_category)
      category = ChatBot::Category.create(name: Faker::Name.name)
      sub = SubCategory.create(name: Faker::Name.name, category_id: category.id)
      p sub.errors
      should validate_uniqueness_of(:name).case_insensitive.scoped_to(:category_id)
    end
  end


end

=begin
module ChatBot
  class SubCategoryTest < ActiveSupport::TestCase

    def setup
      @category = Category.new name: 'Introduction'
      @sub_category = SubCategory.new name: 'Application Intro', category: @category
    end

    def test_validate_name
      assert @sub_category.save

      ## Uniqueness
      sub_category = SubCategory.new category: @category, name: 'Application Intro'
      assert_not sub_category.save, 'Name is duplicate'

      sub_category = SubCategory.new category: @category, name: 'application intro'
      assert_not sub_category.save, 'Name is duplicate (incase-sensitive)'

      sub_category = SubCategory.new category: @category, name: "application  \t \n intro  \n"
      assert_not sub_category.save, 'Name is duplicate (after squish)'
      
      usage_category = Category.new name: 'Application Usage'
      sub_category = SubCategory.new category: usage_category, name: 'Application Intro'
      assert sub_category.save, 'Same sub category under two different categories.'
      ## Uniqueness END

      ## Presence
      @sub_category.name = ''
      assert_not @sub_category.save, 'Name is blank/nil'
    end

    def test_capitaliez_name
      sub_category = SubCategory.create name: 'applIcatioN inTRoductiON',
        category: @category, description: Faker::Lorem.sentence
      assert_equal sub_category.reload.name, 'Application introduction'
    end


    def test_category_validation
      @sub_category.category = nil
      assert_not @sub_category.save, 'Category is nil'
    end
  end

  describe SubCategory do

    context 'Method' do
      context '#find_or_create' do
        context 'should create single entry for' do
          it "'Home - Registration' and 'Home-Registration' and 'Home -Registration' and 'Home - Registration ' and ' Home - Registration'" do
            Category.destroy_all
            SubCategory.destroy_all
            category = Category.create name: Faker::Lorem.name
            ['Home - Registration', 'Home-Registration', 'Home -Registration', 'Home - Registration ', ' Home - Registration'].each do |sub_cat_name|
              sub = SubCategory.find_or_create(category, sub_cat_name)
            end
            assert_equal SubCategory.count, 1
          end
        end
      end
    end

    context 'Dialogue delivery' do

      before(:all) do
        @sub_cat = SubCategory.new name: 'App Intro', category: Category.new(name: 'Introduction')
        @msg_1 = "What would you like to do?"
        @dialog_1 = Dialog.create(sub_category: @sub_cat, message: @msg_1, user_input_type: 'ch')

        @op_11 = 'Play music'
        @op_12 = 'Sleep tight!'
        @option_11 = Option.create(name: @op_11, dialog: @dialog_1)
        @option_12 = Option.create(name: @op_12, dialog: @dialog_1)
        @sub_cat.update_attributes({initial_dialog: @dialog_1})

        @msg_2 = 'Ok, Which artist?'
        @dialog_2 = Dialog.create(sub_category: @sub_cat, message: @msg_2, user_input_type: 'ch')
        op_21 = 'Shreya Ghoshal'
        op_22 = 'Katy Perry'
        option_21 = @dialog_2.options.create(name: op_21)
        option_22 = @dialog_2.options.create(name: op_22)
        @option_json = [{id: option_21.id, name: op_21}, {id: option_22.id, name: op_22}]

        @option_11.update_attribute(:decision, @dialog_2)
      end

      it 'Start conversation should return data of initial dialog' do
        assert_equal SubCategory.start(@sub_cat), { id: @dialog_1.slug, message: @msg_1, user_input_type: 'ch',
                                                    formatted_message: @msg_1,
                                                    options: [{id: @option_11.id, name: @op_11},
                                                              {id: @option_12.id, name: @op_12}]
        }
      end

      context "#next_dialog for an option should return" do
        context "dialog's & its options with user input option equal to" do
          it '"ch" i.e. choice & normal text' do
            assert_equal SubCategory.next_dialog(@option_11.id), { id: @dialog_2.slug, message: @msg_2, user_input_type: 'ch',
                                                                     formatted_message: @msg_2,
                                                                     options: @option_json}
          end

          it '"cnt" i.e. Botcontinue & formatted message including iframe tag to display youtube video' do
            @msg_2 = 'aBcd-eFg'
            @dialog_2.update_attributes(message: @msg_2, user_input_type: 'cnt', message_type: 'utube')

            assert_equal SubCategory.next_dialog(@option_11.id), { 
              id: @dialog_2.slug, message: @msg_2, user_input_type: 'cnt',
              formatted_message: "<iframe width='229' height='200' src='https://www.youtube.com/embed/aBcd-eFg' frameborder='0' allowfullscreen></iframe>", options: @option_json}
          end

          it '"slt" i.e. Single line text & formatted message including iframe tag to display vimeo video' do
            @msg_2 = '1234321'
            @dialog_2.update_attributes(message: @msg_2, user_input_type: 'slt', message_type: 'vimeo')

            assert_equal SubCategory.next_dialog(@option_11.id), {
              id: @dialog_2.slug, message: @msg_2, user_input_type: 'slt',
              formatted_message: "<iframe width='229' height='200' src='https://player.vimeo.com/video/#{@msg_2}' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>", options: @option_json}
          end

          it '"mlt" i.e. Multi line text & formatted message including link tag' do
            @msg_2 = 'https://github.com/anujaware'
            @dialog_2.update_attributes(message: @msg_2, user_input_type: 'mlt', message_type: 'link')

            assert_equal SubCategory.next_dialog(@option_11.id), { id: @dialog_2.slug, message: @msg_2, user_input_type: 'mlt',
                                                                     formatted_message: "<a href='#{@msg_2}' target='_'>Click here.</a>",
                                                                     options: @option_json}
          end

          it '"ddw" i.e. dropdown & formatted message including image tag' do
            @msg_2 = "http://media2.intoday.in/indiatoday/images/stories/collagea_647_083016020529.jpg"
            @dialog_2.update_attributes(message: @msg_2, user_input_type: 'ddw', message_type: 'img')

            assert_equal SubCategory.next_dialog(@option_11.id), { id: @dialog_2.slug, message: @msg_2, user_input_type: 'ddw',
                                                                     formatted_message: "<img src=#{@msg_2}/>",
                                                                     options: @option_json}

          end

          it '"attach" i.e. attachment' do
            @dialog_2.update_attributes(user_input_type: 'attach')
            assert_equal SubCategory.next_dialog(@option_11.id), { id: @dialog_2.slug, message: @msg_2, user_input_type: 'attach',
                                                                     formatted_message: @msg_2,
                                                                     options: @option_json}
          end
        end
      end
    end
  end
=end
