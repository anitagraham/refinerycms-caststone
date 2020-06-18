require 'spec_helper'

module Refinery
  module Caststone
    describe Photo do
      describe "validations" do

        it "Creates a valid photo" do
          let(:photo) { FactoryBot.create(:photo, name: "Refinery CMS") }

          expect(photo).to be_valid
          expect(photo.name).to eq("Refinery CMS")
        end
      end

      describe '#sanitize_name' do
        let(:photo) { FactoryBot.create(:photo, name: "Refinery CMS") }
        let(:photo_with_trailing_spaces) { FactoryBot.create(:photo, name: "CMS   ") }
        let(:photo_with_funny_characters) { FactoryBot.create(:photo, name: "/\/\tents/\/") }
        let(:photo_with_version_code){ FactoryBot.create(:photo, name: "My Photo (31)") }

        it "will not make changes to a simple name" do
           expect(photo.name).to eq("Refinery CMS")
        end

        it "will strip leading and trailing space from a name" do
           expect(photo_with_trailing_spaces.name).to eq("CMS")
        end
        it "will replace non-alphanumeric, space, hyphen or underscore with underscores" do
           expect(photo_with_funny_characters.name).to eq("__tents__")
        end

        it "will remove bracketed numbers at the end of name" do
          expect(photo_with_version_code.name).to eq("My Photo")
        end

      end
    end
  end
end
