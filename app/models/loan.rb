class Loan < ApplicationRecord
  # Direct associations

  has_many   :pmt_adjustments,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
