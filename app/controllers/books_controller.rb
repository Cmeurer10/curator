require 'open-uri'

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_course, except: [:new]

  # GET /books
  # GET /books.json
  def index
    @books = policy_scope(Book).where(course: @course)
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @conversations = @book.conversations
    authorize @book    

    # TODO: Spinner with Jquery?
    @chapter = open("https://storage.googleapis.com/the-curator/#{@book.file.path}").read.gsub(/<style.*<\/style>/, "")

    
  end

  # GET /books/new
  def new
    @book = Book.new
    @course = Course.find(params[:course_id])
    authorize @book
  end

  # GET /books/1/edit
  def edit
    authorize @book
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.course = @course
    authorize @book

    respond_to do |format|
      if @book.save
        format.html { redirect_to courses_path, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    authorize @book
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to courses_path, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    authorize @book
    @book.remove_file
    @book.save
    @book.destroy
    respond_to do |format|
      format.html { redirect_to courses_path, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def set_course
      # TODO: make the correct course
      @course = @book.nil? ? Course.find(params[:course_id]) : @book.course
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author, :publisher, :isbn, :course_id,
                                   :file, :file_cache, :cover, :cover_cache)
    end
end
