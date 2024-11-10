class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :show, :buy, :my_list, :new]
  before_action :set_post, only: [:edit, :update, :destroy, :show, :buy, :cancel, :completed]

  def index

    # クエリパラメータ取得
    @query = params[:query] || ''
    @sort_option = params[:sort] || 'created_at_desc'

    # ポスト取得,検索処理
    @posts = Post.all
    if @query.present?
      @posts = @posts.where('title LIKE ? OR author LIKE ?', "%#{@query}%", "%#{@query}%")
    end

    # ソート処理
    case @sort_option
    when 'price_desc'
      @posts = @posts.order(price: :desc)
    when 'price_asc'
      @posts = @posts.order(price: :asc)
    when 'created_at_desc'
      @posts = @posts.order(created_at: :desc)
    when 'created_at_asc'
      @posts = @posts.order(created_at: :asc)
    else
      @posts = @posts.order(created_at: :desc) 
      # デフォルト新しい順
    end
      @posts = @posts.where(is_receive: false)
      @no_results = @posts.empty?
  end


  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.seller_name = current_user.name
    @post.is_receive = false
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(current_user.id)
  end

  def show
    @talk = Talk.new
  end

  def buy
    @post.update(bought_id: current_user.id, is_sold: true)
    seller_id = @post.user_id
    seller = User.find(seller_id)
    NotifierMailer.item_sold_email(seller, @post).deliver_now
    redirect_to post_path(@post)
  end

  def cancel
    @post.update(bought_id: 0, is_sold: false)
    seller_id = @post.user_id
    seller = User.find(seller_id)
    NotifierMailer.item_cancel_email(seller, @post).deliver_now
    redirect_to post_path(@post)
  end

  def completed
    @post.update(bought_id: 0, is_receive: true)
    redirect_to post_path(@post)
  end

  def my_list
    @posts = Post.where(bought_id: current_user.id).order(created_at: :desc)
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  
  def post_params
    params.require(:post).permit(:title, :content, :price, :image, :author)
  end

  

end
