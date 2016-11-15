class QuotesController < ApplicationController

  def new
    get_person
    @quote = @person.quotes.new
  end

  def create
    get_person
    @quote = @person.quotes.new(quote_params)
    if @quote.save
      redirect_to person_path(@quote.person_id)
    else
      redirect_to new_person_quote_path(@quote.person_id)
    end
  end

  def edit
    get_person
    @quote = Quote.find(params[:id])
  end

  def update
    @quote = Quote.find(params[:id])
    @quote.update(quote_params)
    if @quote.save
      redirect_to person_path(@quote.person_id)
    else
      redirect_to edit_quote_path(@quote.id)
    end
  end

  def destroy
    Quote.delete(params[:id])
    redirect_to person_path(session[:person_id])
  end

  private

  def get_person
    @person = Person.friendly.find(session[:person_id])
  end

  def quote_params
    params.require(:quote).permit(:text, :person_id)
  end

end
