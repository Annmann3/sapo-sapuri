class Dosage < ApplicationRecord
  belongs_to :user
  belongs_to :nutrient

  validates :dosage, presence: true, numericality: true
  validates :dosage_at, presence: true

  scope :last_dosage, -> { order(dosage_at: :desc).first }
end
