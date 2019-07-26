class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:index]

  def index
    @photos = Photo.all
  end

  # GET /photos/:user_id/:photo_id
  def show
    @photo = Photo.find params[:id]
    @creator = User.find(@photo.user_id)
    @user = current_user
    puts "PHOTO FROM SHOW #{@photo}"
  end

  def user_wall
    puts params
    @user = current_user
    @creator = User.find(params[:creator_id])
    @photos = Photo.where(user_id: @creator.id)
  end

  # GET /photos/:user_id/new
  def new
    @photo = Photo.new
    @user = current_user
    # = simple_form_for(@user, html: { class: 'form-inline' }) do |form|
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    puts params

    @photo.save

    respond_to do |format|
      if @photo.save
        puts "SAVED"
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        puts "NOT SAVED"
        puts @photo.errors.full_messages
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image, :user_id)
    end

end
