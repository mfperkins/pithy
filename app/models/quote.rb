class Quote < ApplicationRecord

  belongs_to :person

  validates :text, presence: true

end
