class Nutrient < ApplicationRecord
  has_many :dosages

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :default_unit, presence: true, length: { maximum: 2 }
  validates :graph_type, presence: true, numericality: true
  validates :dosage_recommendation, presence: true, length: { maximum: 600 }
  validates :vdf, numericality: true
  validates :ka, numericality: true
  validates :ke, numericality: true
  validates :lag_time, numericality: true

  # 24時間の血中濃度
  def calculate_24hours(dosages, start = Time.now)
    blood_list = []
    (24 * 60).times do |n|
      data = {
        x: start + n.minute,
        y: dosages * calculate_per_dosages(n / 60.0)
      }
      blood_list.push(data)
    end
    blood_list
  end

  private

  # 時刻tにおける単位容量あたりの血中濃度
  def calculate_per_dosages(t)
    vdf * ka * Math.exp(-ka * t) * t
  end
end
