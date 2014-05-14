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

          it "has associated products" do
            expect(component).to respond_to(:products)
          end
        end
      end

      describe '#ready' do

      end

      describe '.filter_by_product' do
        before do
          @series = FactoryGirl.create(:series, :name=>'TestSeries')
          FactoryGirl.create(:component)
           @comp3  = FactoryGirl.create(:component, :name => 'comp3', :type => 'Shaft', :height =>300, :products=>[:NotherSeries])
          @inTestSeries = described_class.filter_by_product(@series.id)
        end
        it 'returns all the components in a series' do
          expect(@inTestSeries).to include('comp1', 'comp2')
        end

        it "doesn't return a component not in the series" do
          expect(@inTestSeries).to not_include('comp3')
        end

      end

    end
  end
end
