class Person < ApplicationRecord

  has_many :quotes, dependent: :destroy

end
