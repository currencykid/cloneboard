class Post < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  belongs_to :category
  has_attached_file :image, styles: {medium: "300x300>" }
   validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/                                     
   validates :category, presence: true
  validates :image, presence: true 
end
