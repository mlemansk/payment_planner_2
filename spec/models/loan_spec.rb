require 'rails_helper'

RSpec.describe Loan, type: :model do
  
    describe "Direct Associations" do

    it { should belong_to(:user) }

    it { should have_many(:pmt_adjustments) }

    end

    describe "InDirect Associations" do

    end

    describe "Validations" do
      
    end
end
