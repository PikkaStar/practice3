class BooksController < ApplicationController
  before_action :move_to_signed_in
  before_action :correct_user,only: [:edit,:update]
  def new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book.id),notice: "投稿しました"
  else
     @user = current_user
    @books = Book.all
    render :index
    @book = Book.new

  end
  end

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @user = current_user
    @book = Book.find(params[:id])
    @book_new = Book.new
    @book_comment = @book.book_comments
    @comment = current_user.book_comments.new(book_id: @book.id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book),notice: "更新しました"
  else
    render :edit
  end
end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title,:body)
  end

  def move_to_signed_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def correct_user
      @book = Book.find(params[:id])
      @user = @book.user
      redirect_to(books_path) unless @user == current_user
    end


end
