require 'spec_helper'

module Refinery
  module Caststone
    describe Component do
      let(:component) {FactoryBot::create(:component, name: "comp1", type: 'Shaft', height: 350)}

      describe "validations" do
        it "requires a name" do
          expect(FactoryBot.build(:component, name: "")).to be_invalid
        end

        it "requires a unique name" do
          expect(FactoryBot.build(:component, name: component.name)).to be_invalid
        end

        it "requires a valid type" do
          expect(component.type).to be_in(::Refinery::Caststone::Component::COMP_TYPES)
          expect(FactoryBot.build(:component, type: "Gadget")).to be_invalid
        end

        it "requires a numerical height" do
          expect(component.height).to be_an_integer
          expect(FactoryBot.build(:component, height:nil)).to be_invalid
        end

        describe "products association" do

          it "has associated products" do
            expect(component).to respond_to(:products)
          end
        end
      end

      describe '#ready' do
      end
    end
  end
end
