class User < ApplicationRecord
  has_many :watches, dependent: :destroy
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def self.ransackable_associations(auth_object = nil)
    %w[watches]
    # Add associations that you want to be searchable by Ransack here.
    # For example:
    # %w[watches orders]
  end

def self.ransackable_attributes(auth_object = nil)
    %w[created_at email id jti reset_password_token updated_at]
    # Add attributes that you want to be searchable by Ransack here.
    # Make sure to include reset_password_token
  end

end