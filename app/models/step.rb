class Step < ApplicationRecord
  belongs_to :recipe
  has_many :types
end
