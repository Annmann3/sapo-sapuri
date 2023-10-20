class Dosage < ApplicationRecord
  belongs_to :user
  belongs_to :nutrient

  validates :amount, presence: true, numericality: true
  validates :dosage_at, presence: true

  scope :last_dosage, -> { order(dosage_at: :desc).first }
  scope :in_24hours, -> { where(dosage_at: 24.hours.ago..Time.zone.now) }

  # 服用時間の分単位に切り捨て
  def at_min
    dosage_at.change(sec: 0)
  end
end
