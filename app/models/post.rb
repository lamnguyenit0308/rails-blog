class Post < ApplicationRecord
  enum status: { draft: 0, published: 1 }

  belongs_to :user, class_name: "User", foreign_key: "author_id"
  has_one_attached :cover_photo_link

  scope :published_or_authored_by, ->(user) {
    if user
      published.or(where(author_id: user.id)).includes(:user, :cover_photo_link_attachment)
    else
      published.includes(:user, :cover_photo_link_attachment)
    end
  }

  def self.ransackable_attributes(auth_object = nil)
    [ "content", "title" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "cover_photo_link_attachment", "cover_photo_link_blob", "user" ]
  end

  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 10000000 }
  validate :cover_photo_link_file_format

  def cover_photo_link_file_format
    if !cover_photo_link.attached? || (cover_photo_link.attached? && !cover_photo_link.content_type.in?(%w[image/jpeg image/png]))
      errors.add(:cover_photo_link, "must be a JPEG or PNG file")
    end
  end
end
