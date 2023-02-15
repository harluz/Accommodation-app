class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :load_room, only: [:show, :update, :destroy]
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def new
    @user = current_user
    @room = Room.new
  end
  
  def create
    @room = Room.new(room_params)
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
    @reservation = Reservation.new
  end

  def edit
    # @room = Room.find(params[:id])
  end

  def update
    # エラーが発生したらbefore_actionを確認すること
    if @room.update(room_params)
      flash[:notice] = "施設情報を更新しました。"
      redirect_to :rooms
    end
  end

  def destroy
    @room.destroy
    flash[:notice] = "施設情報を削除しました。"
    redirect_to rooms_index_path
  end

  def own
    @rooms = current_user.rooms
  end
  

  private

    def room_params
      params.require(:room).permit(:name,:detail, :adress, :price, :image)
    end

    def load_room
      @room = Room.find(params[:id])
    end
    
    
    def ensure_user
      @rooms = current_user.rooms
      @room = @rooms.find_by(id: params[:id])
      # current_userのroomでなければ飛ばす
      redirect_to room_index_path unless @room
    end
  

  protected

    def defualt_room_image
      if !@room.image.attached?
        @room.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-room-image.png')), filename: 'default-room-image.png', content_type: 'image/png')
      end
    end
  
end
