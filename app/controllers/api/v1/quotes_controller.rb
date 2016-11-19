class Api::V1::QuotesController < Api::V1::BaseController

  def index
    person = Person.friendly.find(params[:person_id])
    quotes = person.quotes.select(:id, :text).sample['text']
    render json: quotes
  end

  def show
    person = Person.friendly.find(params[:person_id])
    quote = person.quotes.find(params[:id])
    render json: quote
  end
end
