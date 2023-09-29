class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  # Con esto le decimos al programa que si el usuario no esta identificado,
  # en la vista index, solo nos muestre la accion de "show"

  before_action :correct_user, only: [:edit, :update, :destroy]
  # Con esto te permite solo ver a los friends que tu no diste de alta, las acciones
  # aqui listadas estaran prohibidas
  
  def index
    @friends = Friend.all
  end


  def show
  end


  def new
    #@friend = Friend.new
    @friend = current_user.friends.build
  end

  def edit
  end

  def create
   # @friend = Friend.new(friend_params)
   @friend = current_user.friends.build(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @friend.destroy

    respond_to do |format|
      format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @friend = current_user.friends.find_by(id: params[:id])
    redirect_to friends_path, notice: "Not Authorized to Edit This Friend" if @friend.nil?
  end
  # Estas lineas de codigo te permiten restringir el uso de cualquier cosa, si 
  # esque el usuario no es el current_user

  private
    def set_friend
      @friend = Friend.find(params[:id])
    end

    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :phone, :twitter, :user_id)
    end
end
