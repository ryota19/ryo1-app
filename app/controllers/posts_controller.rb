class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create 
    @post =Post.create(post_params.merge(user_id: current_user.id))

    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to posts_url
    else
      render :edit
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
     flash[:notice] = "投稿を編集しました"
     redirect_to posts_url
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(:text)
  end

end
