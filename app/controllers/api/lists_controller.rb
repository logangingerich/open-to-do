class Api::ListsController < ApiController
  before_action :authenticated?
  before_action :authorized_for_update?, :only => [:update]

  def create
    user = User.find(params[:user_id])
    list = user.lists.create(list_params)
    if list.save
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      list = List.find(params[:id])
      list.destroy
      render json: {}, status: :no_content
      puts "List Deleted!"
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end

  def update
    list = List.find(params[:id])
    if list.update(list_params)
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    user = User.find(params[:user_id])
    lists = user.lists
    render json: lists
  end

  private
  def list_params
    params.require(:list).permit(:title, :private)
  end

  def authorized_for_update?
    list = List.find(params[:id])
    current_user = User.find(params[:id])
    unless list.user.id == current_user.id
      raise "Not Authorized"
    end
  end

end
