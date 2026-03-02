class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :timeoutable, :lockable
  
  belongs_to :role, optional: true
  has_many :courses, dependent: :destroy
  has_many :operation_logs, dependent: :nullify
  
  has_one_attached :avatar
  
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }, format: { with: /\A[\w\u4e00-\u9fa5]+\z/, message: '只能包含字母、数字、下划线和中文' }
  validates :bio, length: { maximum: 200 }, allow_blank: true
  validate :avatar_format
  validate :avatar_size
  
  def avatar_format
    return unless avatar.attached?
    unless avatar.content_type.in?(%w(image/jpeg image/png image/jpg))
      errors.add(:avatar, '必须是 JPG 或 PNG 格式')
    end
  end
  
  def avatar_size
    return unless avatar.attached?
    if avatar.byte_size > 5.megabytes
      errors.add(:avatar, '大小不能超过 5MB')
    end
  end

  def has_permission?(resource, action)
    return true if is_admin?
    return false unless role
    role.has_permission?(resource, action)
  end

  def is_admin?
    is_admin
  end

  def online?
    online_status == 'online'
  end
end
