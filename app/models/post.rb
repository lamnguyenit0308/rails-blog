class Post < ApplicationRecord
  belongs_to :users, class_name: "User", foreign_key: "author_id"
  has_one_attached :cover_photo_link
  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 10000000 }
  # validate :cover_photo_link_file_format
  scope :published, -> { where(status: 1) }

  # def cover_photo_link_file_format
  #   if !cover_photo_link.attached? || (cover_photo_link.attached? && !cover_photo_link.content_type.in?(%w[image/jpeg image/png]))
  #     errors.add(:cover_photo_link, "must be a JPEG or PNG file")
  #   end
  # end
end
