class WebContent < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :title, presence: true, length: { maximum: 200 }
  validates :slug, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :content_type, presence: true, inclusion: { in: %w(page article news event) }

  scope :published, -> { where(is_published: true) }
  scope :by_content_type, ->(type) { where(content_type: type) }
  scope :ordered, -> { order(position: :asc, created_at: :desc) }

  before_validation :generate_slug, unless: :slug?

  def publish!
    update(is_published: true, published_at: Time.current)
  end

  def unpublish!
    update(is_published: false, published_at: nil)
  end

  private

  def generate_slug
    self.slug = title.parameterize if title.present?
  end
end
