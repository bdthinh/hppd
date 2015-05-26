class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @categories = Category.all
  end

  # GET /posts/1/edit
  def edit
    @categories = Category.all
    @categories_of_post = CategoriesOfPost.where(post_id: params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.update(admin_id: current_user.id)
    respond_to do |format|
      if @post.save
        category_ids_param.each do |category_id|
          CategoriesOfPost.where(post_id: @post.id, category_id: category_id).first_or_create
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    category_ids_of_post = CategoriesOfPost.where(post_id: params[:id]).pluck(:category_id).map(&:to_s)
    add_ids = category_ids_param - category_ids_of_post
    del_ids = category_ids_of_post - category_ids_param
    respond_to do |format|
      if @post.update(post_params)
        add_ids.each do |category_id|
          CategoriesOfPost.where(post_id: @post.id, category_id: category_id).first_or_create
        end
        del_ids.each do |category_id|
          CategoriesOfPost.where(post_id: @post.id, category_id: category_id).destroy_all
        end
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :subtitle, :content)
    end
    def category_ids_param
      params[:category_ids] || []
    end
end
