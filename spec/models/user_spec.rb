require 'rails_helper'

RSpec.describe User, type: :model do
  
    describe "Direct Associations" do

    it { should have_many(:loans) }

    it { should have_many(:pmt_adjustments) }

    end

    describe "InDirect Associations" do

    end

    describe "Validations" do
      
    end
end
