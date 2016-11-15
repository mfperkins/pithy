class PeopleController < ApplicationController

  def index
    @people = Person.all
    session[:person_id] = nil
  end

  def show
    session[:person_id] = params[:id]
    @person = Person.friendly.find(params[:id])
    @quotes = Quote.where(person_id: @person.id)
  end

end
