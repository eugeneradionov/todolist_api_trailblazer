class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :projects, dependent: :destroy

  validates :email, presence: true, uniqueness: true, case_sensitive: false, length: { maximum: 63 }
  validate :password_validation

  private

  def password_validation
    if password.present? && !password.match(/^(?=.*[a-zA-Z])(?=.*\d).{8,}$/)
      errors.add :password, I18n.t('errors.password_validation')
    end
  end
end
