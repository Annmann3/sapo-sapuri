class Nutrient < ApplicationRecord
  include CommonConsts
  has_many :dosages

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :default_unit, presence: true, length: { maximum: 2 }
  validates :graph_type, presence: true, numericality: true
  validates :dosage_recommendation, presence: true, length: { maximum: 600 }
  validates :vdf, numericality: true
  validates :ka, numericality: true
  validates :ke, numericality: true

  # 1分間隔の24時間の血中濃度の配列
  def calculate_24hours(dosages, start = Time.zone.now)
    (0...(24 * 60)).map do |n|
      {
        x: start + n.minute,
        y: dosages * calculate_concentration(n / 60.0)
      }
    end
  end

  # 現在時刻から前後１２時間の濃度0の配列
  def calculate_zero
    (0...(24 * 60)).map do |n|
      {
        x: Time.zone.now + n.minute - 12.hours,
        y: 0
      }
    end
  end

  def calculate_combined_24hours(dosages)
    data = []
    dosages.each do |dosage|
      data += (0...(24 * 60)).map do |n|
        {
          x: dosage.at_min + n.minute,
          y: dosage.amount * calculate_concentration(n / 60.0)
        }
      end
    end
    merge_duplicate_x(data)
  end

  # 最後の服用からGOAL_SPAN時間後の達成判定する下限値
  def calculate_goal(dosage)
    goal_span_in_hours = (CommonConsts::GOAL_SPAN / 3600.0).to_f
    {
      x: dosage.at_min + CommonConsts::GOAL_SPAN,
      y: dosage.amount * calculate_concentration(goal_span_in_hours)
    }
  end

  private

  # 服用してからt時間後の単位服用量あたりの血中濃度
  def calculate_concentration(t)
    ka * Math.exp(-ka * t) * t / vdf
  end

  def merge_duplicate_x(data)
    result = {}
    data.each do |d|
      x = d[:x]
      y = d[:y]

      if result.key?(x)
        result[x] += y
      else
        result[x] = y
      end
    end
    result.map { |x, y| { x:, y: } }
  end
end
