class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]

  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = Conversation.all
    respond_to do |format|
      format.html
      format.js
    end

    @conversations = policy_scope(Conversation).where(book: params[book:id])

  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    authorize @conversation
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
    authorize @conversation
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)
    @book = Book.find(params[:book_id])
    authorize @conversation

    respond_to do |format|
      if @conversation.save!
        # format.html { redirect_to @conversation.book, notice: 'Conversation was successfully created.' }
        # format.html { redirect_to "/books/#{@conversation.book_id}", notice: 'Conversation was successfully created.' }
        # format.html { render partial: "/books/sidebar/conversations", notice: 'Conversation was successfully updated.' }
        # # format.json { render :show, status: :created, location: @conversation.book }
        # format.json { render :show, status: :created, location: "/books/#{@conversation.book_id}" }
        @conversations = @book.conversations
        format.js { render :index }
      else
        # format.html { render :new }
        format.html { redirect_to "/books/#{@conversation.book_id}", notice: 'Conversation failed' }

        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    authorize @conversation
    respond_to do |format|
      if @conversation.update(conversation_params)
        # format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        # format.html { redirect_to "/books/#{@conversation.book_id}", notice: 'Conversation was successfully updated.' }
        format.html { render "books/sidebar/posts", notice: 'Conversation was successfully updated.' }
        # format.json { render :show, status: :ok, location: @conversation }
        format.json { render :show, status: :ok, location: "/books/#{@conversation.book_id}" }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    authorize @conversation
    set_book
    unless Conversation.where(parent_id: @conversation.id).empty?
      child_conversations = Conversation.where(parent_id: @conversation.id).to_a
      new_parent = child_conversations.sample
      new_parent.start_index = @conversation.start_index
      new_parent.end_index = @conversation.end_index
      new_parent.parent_id = nil
      if child_conversations.length > 1
        child_conversations.reject! { |c| c == new_parent }
        child_conversations.each do |c|
          c.parent_id = new_parent.id
          c.save
        end
      end
      new_parent.save
    end
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to book_path(@book) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    def set_book
      @book = @conversation.book
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params

      params.require(:conversation).permit(:book_id, :topic, :start_index,
      :end_index, :user_id, :parent_id)
    end
end
