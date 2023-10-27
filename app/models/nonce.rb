class Nonce < ActiveRecord::Base
  after_initialize :generated_nonce, if: :new_record?
  belongs_to :user
  validates :val, presence: true, length: { minimum: 10, maximum: 255 }


  
  #セッターとしてvalを設定する
  private

  def generated_nonce
    random_data = SecureRandom.random_bytes(16)
    self.val = Base64.strict_encode64(random_data)
  end
end
