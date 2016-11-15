class Api::V1::QuotesController < Api::V1::BaseController

  def show
    quote = Quote.find(params[:id])
    render(json: Api::V1::UserSerializer.new(quote).to_json)
  end
end
