 require 'spec_helper'

 module Refinery
   module Caststone

     describe Product do
       let(:product){FactoryBot.create(:product, name: 'Refinery CMS')}

       describe "validations" do
         context "when created with required fields" do
           it "is a valid object" do
             expect(product).to be_valid
             expect(product.name).to eq("Refinery CMS")
           end
         end

       end
     end

   end
 end
