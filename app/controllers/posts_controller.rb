class PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy, :upvote]
  before_action :set_conversation, only: [:index, :create, :update, :destroy, :refresh_part, :upvote]
  before_action :set_book, only: [:index, :update, :create, :destroy, :refresh_part, :upvote]

  skip_after_action :verify_authorized, only: [:refresh_part]
  after_action :verify_policy_scoped, only: [:refresh_part]

  def index
    @posts = policy_scope(Post).where(conversation: @conversation)
    @post = params[:post_id].nil? ? Post.new : Post.find(params[:post_id])
    respond_to do |format|
      # format.html
      format.js
    end
  end

  def show
    authorize @post
    respond_to do |format|
      format.html
      format.js
    end
  end


  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.conversation = @conversation
    @post.user = current_user
    authorize @post

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
    authorize @post
    respond_to do |format|
      @post.update(post_params)
      @post = Post.new
      format.js { render :index }
    end
  end

  def destroy
    authorize @post
    respond_to do |format|
      if @post.destroy
        @post = Post.new
        format.js { render :index }
      else
        format.html { redirect_to @post.conversation.book }
      end
    end
  end

  def refresh_part
    # get whatever data you need to a variable named @data
    @posts = policy_scope(Post).where(conversation: @conversation)
    respond_to do |format|
      format.js
    end
  end

  def upvote
    authorize @post
    respond_to do |format|
      @post.votes += 1
      if @post.save!
        @post = Post.new
        format.js { render :index }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id].nil? ? params[:id] : params[:post_id])
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
