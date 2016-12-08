class Person < ApplicationRecord

  extend FriendlyId
  friendly_id :nickname, use: :slugged

  has_many :quotes, dependent: :destroy
  has_attached_file :image, :styles => { :large => "500x500",:medium => "300x300>", :thumb => "75x75>" }, :default_url => "default_image.jpg"

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :nickname, presence: true
  validates :first_name, uniqueness: true
  validates :last_name, uniqueness: true
  validates :nickname, uniqueness: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
