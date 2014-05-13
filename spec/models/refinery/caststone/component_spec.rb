require 'spec_helper'

module Refinery
  module Caststone
    describe Component do
      let(:component) {FactoryGirl::create(:component)}

      describe "validations" do

        it "requires a name" do
          expect(FactoryGirl.build(:component, :title => "")).to be_invalid
        end

        it "won't allow a duplicate name" do
          expect(FactoryGirl.build(:component, :title => component.title)).to be_invalid
        end

        it "requires a valid type" do
          expect(component.type).to be_in(COMP_TYPES)
          expect(FactoryGirl.build(:component, :type => nil)).to be_invalid
        end

        it "requires a numerical height" do
          expect(component.height).to be_an_integer
          expect(FactoryGirl.build(:component, :height=>nil)).to be_invalid
        end

        describe "products association" do

          it "have a product attribute" do
            expect(component).to respond_to(:products)
          end
        end

      end
    end
  end
end
