class Person < ApplicationRecord

  extend FriendlyId
  friendly_id :nickname, use: :slugged

  has_many :quotes, dependent: :destroy

end
