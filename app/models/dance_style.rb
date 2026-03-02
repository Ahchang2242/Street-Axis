class DanceStyle < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true

  has_one_attached :uploaded_image

  validate :validate_image

  scope :ordered, -> { order(created_at: :desc) }

  def display_image
    if uploaded_image.attached?
      uploaded_image
    elsif image.present?
      image
    else
      nil
    end
  end

  private

  def validate_image
    if uploaded_image.attached?
      unless uploaded_image.content_type.in?(['image/jpeg', 'image/png', 'image/webp', 'image/gif'])
        errors.add(:uploaded_image, '必须是JPEG、PNG、WebP或GIF格式')
      end
      if uploaded_image.byte_size > 10.megabytes
        errors.add(:uploaded_image, '大小不能超过10MB')
      end
    elsif image.present?
      unless image =~ URI::DEFAULT_PARSER.make_regexp(['http', 'https'])
        errors.add(:image, '必须是有效的URL地址')
      end
    end
  end
end
