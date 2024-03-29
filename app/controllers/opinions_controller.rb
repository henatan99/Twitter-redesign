class OpinionsController < ApplicationController
  before_action :require_login
  before_action :set_opinion, only: %i[show edit update destroy]

  # GET /opinions or /opinions.json
  def index
    @opinion = Opinion.new
    @opinions = Opinion.order('created_at DESC')
    @tofollow_users = User.all_except(current_user) - @current_user.followeds
    @current_user_followings = current_user.followeds
  end

  # GET /opinions/1 or /opinions/1.json
  def show; end

  # GET /opinions/new
  def new
    @opinion = Opinion.new
  end

  # GET /opinions/1/edit
  def edit; end

  # POST /opinions or /opinions.json
  def create
    @opinion = current_user.opinions.new(opinion_params)

    respond_to do |format|
      if @opinion.save
        format.html { redirect_to root_path, notice: 'Opinion was successfully created.' }
        format.json { render :show, status: :created, location: @opinion }
      else
        format.html { render :new, alert: 'You post is not valid! Please Edit.', status: :unprocessable_entity }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opinions/1 or /opinions/1.json
  def update
    respond_to do |format|
      if @opinion.update(opinion_params)
        format.html { redirect_to @opinion, notice: 'Opinion was successfully updated.' }
        format.json { render :show, status: :ok, location: @opinion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opinions/1 or /opinions/1.json
  def destroy
    @opinion.destroy
    respond_to do |format|
      format.html { redirect_to opinions_url, notice: 'Opinion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # def timeline_opinions
  #   @timeline_opinions ||= Opinion.all.ordered_by_most_recent.includes(:author)
  # end

  def set_opinion
    @opinion = Opinion.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def opinion_params
    params.require(:opinion).permit(:text, :author_id)
  end
end
