class UsersController < ApplicationController
  before_action :set_current_user
  before_action :authenticate_user,{only:[:edit, :update, :index, :show]}
  before_action :ensure_correct_user,{only:[:edit, :update, :delete]}
  before_action :forbid_login_user,{only:[:new, :create, :login_form, :login]}
  def new
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password_digest: params[:password],
      profiel_image: "default_user.jpg"
    )
      if params[:password] == params[:password2] && @user.save
        session[:user_id] = @user.id
        flash[:notice] ="ユーザー登録に成功しました"
        redirect_to("/posts/index")
      elsif params[:name].blank? 
        flash[:alert] = "ユーザー名を登録してください"
        redirect_to("/signup")
      elsif params[:email].blank?
        flash[:alert] = "メールアドレスを登録してください"
        redirect_to("/signup")
      elsif params[:password].blank?
        flash[:alert] = "パスワードを登録してください"
        redirect_to("/signup")
      elsif params[:password] != params[:password2]
        flash[:alert] = "パスワードとパスワード確認が一致しません"
        redirect_to("/signup")
      end
      @user.save
  end
  
  def show
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: params[:id])
    @post_data = Post.where(user_id: params[:id])
    @posts = Kaminari.paginate_array(@post_data).page(params[:page]).per(6)
  end
  def likes
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: params[:id])
    @likes = Like.where(user_id: params[:id])
  end
  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.password_digest == params[:password]
      session[:user_id] = @user.id
      flash[:notice] = "ログインに成功しました"
      redirect_to("/users/#{@user.id}")
    elsif !@user
      flash[:alert] = "メールアドレスが間違っています"
      redirect_to("/login")
    elsif @user.password != params[:password]
      flash[:alert] = "パスワードが間違っています"
      redirect_to("/login")
    end

  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトに成功しました"
    redirect_to("/")
  end

  def index
    if params[:serch] == nil || params[:serch] == ""
      @users = User.where.not(id: @current_user).order(name: :DESC)
    else
      @users = User.where("name LIKE ?" , "%#{params[:serch]}%")
    end
  
  end

  def edite
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    puts @user.name
    @user.name = params[:name]
    @user.email = params[:email]
    @user.introduction = params[:introduction]

    if params[:profiel_image]
      @user.profiel_image = "#{@user.id}.jpg"
      image = params[:profiel_image]
      File.binwrite("public/user_images/#{@user.profiel_image}" , params[:profiel_image].read)
    end

    if @user.save
      flash[:notice] = "編集が完了しました!"
      redirect_to("/users/#{@user.id}")
    else
      flash[:alert] = "更新できませんでした"
      redirect_to("/users/#{@user.id}/edit")
    end
  end

  def delete
    @user = User.find_by(id: @current_user.id)
    @user.destroy
    redirect_to ("/")
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    if @current_user != @user
      flash[:notice] = "権限がありません"
      redirect_to request.referrer || "/posts/index"
    end
  end

end