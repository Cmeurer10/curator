class PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy]
  before_action :set_conversation, only: [:index, :create, :destroy]
  before_action :set_book, only: [:index, :create, :destroy]

  def index
    @posts = policy_scope(Post).where(conversation: @conversation)
    @post = Post.new
    respond_to do |format|
      format.html
      format.js 
    end
  end

  def show
    authorize @post
  end


  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.conversation = @conversation
    @post.user = current_user

    respond_to do |format|
      if @post.save
        @post = Post.new
        format.js { render :index }
      else
        format.html { redirect_to @post.conversation.book }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @post.destroy
        @post = Post.new
        format.js { render :index }
      else
        format.html { redirect_to @post.conversation.book }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
      @posts = Post.where(conversation: @conversation)
    end

    def set_book
      @book = @conversation.book
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content)
    end
end
