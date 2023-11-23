class Nonce < ApplicationRecord
  after_initialize :generated_nonce, if: :new_record?
  belongs_to :user
  validates :val, presence: true, length: { minimum: 10, maximum: 255 }

  # セッターとしてvalを設定する
  private

  def generated_nonce
    self.val = random_data = SecureRandom.urlsafe_base64(16)
  end
end
