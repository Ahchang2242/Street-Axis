class Role < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :role_permissions, dependent: :destroy
  has_many :permissions, through: :role_permissions

  validates :name, presence: true, uniqueness: true

  def has_permission?(resource, action)
    permissions.exists?(resource: resource, action: action)
  end
end
