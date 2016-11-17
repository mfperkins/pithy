class QuotesSerializer < ActiveModel::Serializer
  attributes :id, :text, :person_id
  belongs_to :person
end
