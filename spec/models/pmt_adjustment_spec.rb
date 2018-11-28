require 'rails_helper'

RSpec.describe PmtAdjustment, type: :model do
  
    describe "Direct Associations" do

    it { should belong_to(:user) }

    it { should belong_to(:loan) }

    end

    describe "InDirect Associations" do

    end

    describe "Validations" do
      
    end
end
