class Dosage < ApplicationRecord
  include CommonConsts

  belongs_to :user
  belongs_to :nutrient

  validates :amount, presence: true, numericality: true
  validates :dosage_at, presence: true

  scope :last_dosage, -> { order(dosage_at: :desc).first }
  scope :in_24hours, -> { where(dosage_at: 24.hours.ago..Time.zone.now) }
  scope :in_week_asc, -> { where(dosage_at: 1.week.ago..Time.zone.now) && order(dosage_at: :asc) }

  # 服用時間の分単位に切り捨て
  def at_min
    dosage_at.change(sec: 0)
  end

  # １週間の服用服用服用達成率を計算する
  def self.weekly_achievement_rate(user)
    dosages = user.dosages.in_week_asc
    return 0 if dosages.empty?

    total_time = 0
    dosages.each_cons(2) do |dosage1, dosage2|
      interval = dosage2.dosage_at - dosage1.dosage_at
      total_time += interval if interval < CommonConsts::GOAL_SPAN
    end

    (total_time / 1.week) * 100
  end
end
