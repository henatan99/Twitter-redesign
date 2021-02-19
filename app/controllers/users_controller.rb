class UsersController < ApplicationController
  # before_action :require_login, except: %i[new, create]
  # before_action :set_user, except: %i[ new edit create ]

  # GET /users or /users.json
  def index
    @users = User.all_except(current_user)
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @user_opinions = @user.opinions.includes(:authors).order('created_at DESC')
    @followers = @user.followers
    @followings = @user.followeds
  end

  def following
    @user = User.find(params[:id])
    @followings = @user.followeds
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  def tofollow_users
  end 

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @opinion = Opinion.new
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def follow
    @user = User.find(params[:id])
    following = current_user.follow(@user)
    if following.valid? && @user != current_user
      following.save
      redirect_to root_path, notice: 'You followed successfully!'
    else
      redirect_to root_path, notice: 'Invalid Request!'
    end
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(@user.id)

    redirect_to root_path, notice: 'You Unfollowed successfuly!'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :fullname, :photo, :coverimage)
  end
end
