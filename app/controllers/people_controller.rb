class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def show
    @person = Person.friendly.find(params[:id])
    @quotes = Quote.where(person_id: @person.id)
  end
end
