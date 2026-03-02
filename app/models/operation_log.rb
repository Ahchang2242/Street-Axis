class OperationLog < ApplicationRecord
  belongs_to :user, optional: true

  validates :action, presence: true

  scope :by_action, ->(action) { where(action: action) if action.present? }
  scope :by_user, ->(user_id) { where(user_id: user_id) if user_id.present? }
  scope :by_date_range, ->(start_date, end_date) { where(created_at: start_date..end_date) if start_date.present? && end_date.present? }

  paginates_per 20
end
