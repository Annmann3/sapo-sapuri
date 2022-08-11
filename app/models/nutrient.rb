class Nutrient < ApplicationRecord
  has_many :dosages

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :graph_type, presence: true, numericality: true
  validates :dosage_recommendation, presence: true, length: { maximum: 600 }
  end
