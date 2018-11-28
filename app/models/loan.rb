class Loan < ApplicationRecord
  # Direct associations

  belongs_to :user

  has_many   :pmt_adjustments,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
