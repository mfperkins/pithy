class Api::V1::PeopleController < Api::V1::BaseController

  def show
    person = Person.friendly.find(params[:id])
    render(json: Api::V1::UserSerializer.new(person).to_json)
  end
  
end
