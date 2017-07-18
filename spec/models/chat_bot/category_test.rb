require 'rails_helper'

RSpec.describe ChatBot::Category, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:sub_categories) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
=begin
  Category = ChatBot::Category

  context "Validation" do
    it { should validate_presence_of(:name) }

    # Not able to use this as failing with null constraint at db level
    # So adding test cases for case insensitive uniqueness
    #it { should validate_uniqueness_of(:name).case_insensitive }
    it { should have_many(:sub_categories) }

    before do
      @category = Category.new
    end

    context 'Validation' do
      it 'uniqueness' do
        @category.name = 'Cat 1'
        expect(@category.save).to be_truthy
        category = Category.new name: 'Cat 1' #categories(:two)
        expect(category.save).not_to be_truthy
      end
    end

    context 'before save' do
      it 'squish name' do
        @category.name = "   Cat   \n \t 1  \n "
        expect(@category.save).to be_truthy
        @category.reload
        expect(@category.name).to eq('Cat 1')
      end

      it 'capitalize name' do
        category = Category.create name: 'applIcatioN inTRoductiON'
        expect(category.reload.name).to eq('Application introduction')
      end
    end

    describe 'Method' do
      context '#find_or_create' do
        context 'should create single entry for' do
          it "'Home - Registration' and 'Home-Registration' and 'Home -Registration' and 'Home - Registration ' and ' Home - Registration'" do
            ['Home - Registration', 'Home-Registration', 'Home -Registration', 'Home - Registration ', ' Home - Registration'].each do |cat_name|
              expect(Category.find_or_create(cat_name)).to be_present
            end
            expect(Category.count).to eq(1)
          end
        end
      end
    end

  end
=end
end
