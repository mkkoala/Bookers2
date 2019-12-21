class BooksController < ApplicationController

    before_action :authenticate_user!

    def new
        @book = current_user.books.build
    end
    def create
        @book = current_user.books.build(book_params)
    	@book = Book.new(book_params)
    	@book.user_id = current_user.id
    	if @book.save
    	   redirect_to book_path(@book.id), notice: "You have creatad book successfully."
        else
            @user = current_user
            @books = Book.page(params[:page]).reverse_order
            render :index
        end
    end
    def index
        @user = current_user
    	@books = Book.page(params[:page]).reverse_order
    	@book = Book.new
    end
    def show
        @book = Book.find(params[:id])
        @user = @book.user
        @book_new = Book.new
    end
    def edit
    	@book = Book.find(params[:id])
        if @book.user.id != current_user.id
            redirect_to books_path
        end
    end
    def update
    	@book = Book.find(params[:id])
    	if @book.update(book_params)
    	   redirect_to book_path(@book),notice: "You have updated book successfully."
        else
            render :edit
        end
    end
    def destroy
    	book = Book.find(params[:id])
    	book.destroy
    	redirect_to books_path
    end

    private
    def book_params
      params.require(:book).permit(:title, :body)
    end
end
