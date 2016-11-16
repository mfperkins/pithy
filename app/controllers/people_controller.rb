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

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      puts params[:nickname]
      @person.update(user_id: current_user.id)
      redirect_to root_path
    else
      redirect_to new_person_path
    end
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :last_name, :nickname.downcase)
  end


end
