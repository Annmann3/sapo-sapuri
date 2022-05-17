class Dosage < ApplicationRecord
  belongs_to :user
  belongs_to :nutrient

  validates :dosage, presence: true, numericality: true
  validates :dosage_at, presence: true
end
