class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def show
    @person = Person.find(params[:id])
    @quotes = Quote.where(person_id: @person.id)
  end
end
