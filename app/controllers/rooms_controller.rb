class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @rooms = Room.all
  end

  def new
    @user = current_user
    @room = Room.new
  end
  
  def create
    @room = Room.new(params.require(:room).permit(:name,:detail, :adress, :price, :user_id, :image))
    @room.user_id = current_user.id
    defualt_room_image
    
    if @room.save
      flash[:notice] = "施設の登録が完了しました。"
      redirect_to room_path(@room)
    else
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(params.require(:room).permit(:name,:detail, :adress, :price, :image))
      flash[:notice] = "施設情報を更新しました。"
      redirect_to :rooms
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設情報を削除しました。"
    redirect_to room_index_path
  end

  private

  def room_params
    params.require(:room).permit(:name,:detail, :adress, :price, :image)
  end
  

  protected

  def defualt_room_image
    if !@room.image.attached?
      @room.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-room-image.png')), filename: 'default-room-image.png', content_type: 'image/png')
    end
  end
  
end
