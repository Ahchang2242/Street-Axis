class WebModule < ApplicationRecord
  validates :name, presence: true
  validates :identifier, presence: true, uniqueness: true

  default_scope { order(position: :asc, name: :asc) }

  after_initialize :set_default_config, if: :new_record?

  def toggle_active!
    update(is_active: !is_active)
  end

  def increment_usage!
    increment!(:usage_count)
  end

  private

  def set_default_config
    self.config ||= {}
  end
end
