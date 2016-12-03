class Person < ApplicationRecord

  extend FriendlyId
  friendly_id :nickname, use: :slugged

  has_attached_file :image, :styles => { :large => "500x500",:medium => "300x300>", :thumb => "75x75>" }, :default_url => "default_image.jpg"
  has_many :quotes, dependent: :destroy

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
