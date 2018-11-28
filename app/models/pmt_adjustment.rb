class PmtAdjustment < ApplicationRecord
  # Direct associations

  belongs_to :user

  belongs_to :loan

  # Indirect associations

  # Validations

end
