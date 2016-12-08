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
    check_new_person_in_progress
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      @person.update(user_id: current_user.id)
      redirect_to root_path
    else
      flash[:error] = @person.errors.full_messages.map{|o| o  }.join("/")
      session[:person] = person_params
      redirect_to new_person_path
    end
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.friendly.find(params[:id])
    @person.update(person_params)
    if @person.save
      redirect_to root_path
    else
      redirect_to edit_person_path
    end
  end

  def destroy
    Person.delete(params[:id])
    redirect_to root_path
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :last_name, :nickname.downcase, :image)
  end

  def check_new_person_in_progress
    if session[:person]
      @person = Person.new(session[:person])
      session[:person] = nil
    else
      @person = Person.new
    end
  end

end
