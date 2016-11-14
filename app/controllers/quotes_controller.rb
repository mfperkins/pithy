class QuotesController < ApplicationController

  def new
    @person = Person.find(params[:person_id])
    session[:person_id] = params[:person_id]
    @quote = @person.quotes.new
  end

  def create
    @person = Person.find(session[:person_id])
    @quote = @person.quotes.new(quote_params)
    puts @quote.inspect
    if @quote.save
      redirect_to person_path(session[:person_id])
    else
      redirect_to new_person_quote_path(session[:person_id])
    end
  end


  private

  def quote_params
    params.require(:quote).permit(:text, :person_id)
  end

end
