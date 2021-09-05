class BooksController < ApplicationController
    before_action :authenticate_user!
    
    before_action :ensure_correct_user, only:[:edit]
    
    
    def index
        @book = Book.new(params[:id])
        @books = Book.all
        @user = User.find(current_user.id)
    end
    
    def show
        # @user = User.find(params[:id])
        @book = Book.new
        @books = Book.find(params[:id])
        @user = @books.user
    end
    
    def new
        @book = Book.find(params[:id])
    end
    
    def create
        @books = Book.all
        @user = User.find(current_user.id)
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
          redirect_to book_path(@book.id), notice: "You have created book successfully."
        else
          render :index
        end
    end
    
    def new
        @book = Book.find(params[:id])
    end
    
    def edit
        @book = Book.find(params[:id])
    end
    
    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            redirect_to book_path(@book.id),notice:"You have updated user successfully."
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
    
    def ensure_correct_user
       @book = Book.find(params[:id])
       unless @book.user == current_user
       redirect_to books_path
       end
    end
   
end    