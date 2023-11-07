# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]
  include DeviseTokenAuth::Concerns::User
  has_many :dosages, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_one :nonce, dependent: :destroy

end
