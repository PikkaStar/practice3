class UsersController < ApplicationController
   before_action :move_to_signed_in
    before_action :correct_user,only: [:edit,:update]
    before_action :authenticate_user!, only: [:show]
    
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
     @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user),notice: "更新しました"
  else
    render :edit
  end
  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

  def move_to_signed_in
    unless user_signed_in?
      redirect_to new_user_session_path
  end
end
def correct_user
      @user = User.find(params[:id])
      redirect_to(books_path) unless @user == current_user
    end


end
