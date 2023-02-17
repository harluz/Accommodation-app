class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def confirm
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
    @reservation.user_id = current_user.id
    @reservation.room_id = @room.id
    
    if @reservation.invalid?
      render :new
    end
  end

  def index
    @reservations = Reservation.all
  end
  

  def create
    @reservation = Reservation.new(reservation_params)
    @room = Room.find(params[:reservation][:room_id])
    @reservation.user_id = current_user.id
    @reservation.room_id = @room.id  

    if @reservation.save
      flash[:notice] = "予約が完了しました。"
      redirect_to reservations_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    # @reservation = Reservation.find(params[:id])
  end

  def update
    # @reservation = Reservation.find(params[:id])
    # if @reservation.update(reservation_params)
    #   flash[:notice] = "予約の更新が完了しました。"
    #   redirect_to reservations_confirm_path
    # else
    #   flash[:alert] = "予約の更新に失敗しました。"
    #   render :edit
    # end
  end

  def destroy
  end

  private

    def reservation_params
      params.require(:reservation).permit(:check_in, :check_out, :count_person, :user_id, :room_id)
    end
    
    def ensure_user
      @reservations = current_user.reservations
      @reservation = @reservations.find_by(id: params[:id])
      redirect_back fallback_location: root_path unless @reservation
    end
end
