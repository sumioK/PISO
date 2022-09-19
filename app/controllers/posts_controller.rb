class PostsController < ApplicationController
  before_action :authenticate_user,{only:[:create, :destroy, :show, :update, :edit, :new]}
  before_action :ensure_correct_user,{only:[:edit, :update, :destroy]}
  def new
    @post = Post.new()
  end

  def create
    if params[:image]
      @post = Post.new(
        content: params[:content] ,
        user_id: @current_user.id ,
        image: "image.jpg"
      )
      if @post.save
        @post.image = "#{@post.id}.jpg"
        @post.save
        File.binwrite("public/post_images/#{@post.image}" , params[:image].read)
        redirect_to("/posts/index")
      else
        render("posts/new")
      end
    else
      flash[:alert] = "画像が選択されていません"
      redirect_to("/posts/new")
    end

  end

  def index
    if !params[:serch] || params[:serch] == ""
      # @posts = Post.all.order(created_at: :desc)
      @post_data = Post.all.order(created_at: :desc)
      @posts = Kaminari.paginate_array(@post_data).page(params[:page]).per(5)
      # @posts = Post.page(params[:page]).per(5).order(created_at: :desc)
    else
      @posts = Post.where("content LIKE ?","%#{params[:serch]}%")
    end
  end

  def show
    @post = Post.find_by(id:params[:id])
    @likes_count = Like.where(post_id: @post.id).count
    @comments = Comment.where(post_id: @post.id).order(created_at: :asc).order(created_at: :desc)
  end

  def edit
    @post = Post.find_by(id:params[:id])
  end

  def update
    @post = Post.find_by(id:params[:id])
    @post.content = params[:content]

    if params[:image]
      File.binwrite("public/post_images/#{@post.image}" , params[:image].read)
    end
    
    if @post.save
      redirect_to("/posts/#{@post.id}")
      flash[:notice] = "編集に成功しました"
    else
      render("posts/edit")
    end
  end



  def destroy
    @post = Post.find_by(id:params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post =Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:alert] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
