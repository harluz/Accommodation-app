class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def confirm
    if request.post?
      set_new_reservation
      
      binding.pry
      
    elsif request.patch?
      @reservation = Reservation.find(params[:reservation][:id])
      @reservation.check_in = params[:reservation][:check_in]
      @reservation.check_out = params[:reservation][:check_out]
      @reservation.count_person = params[:reservation][:count_person]
    end

    if @reservation.invalid?
      render "rooms/show"
    end
  end

  def index
    @reservations = current_user.reservations
  end
  

  def create
    set_new_reservation
    if @reservation.save
      flash[:notice] = "予約が完了しました。"
      redirect_to search_rooms_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      flash[:notice] = "予約を更新しました。"
      redirect_to search_rooms_path
    else
      flash[:alert] = "予約の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "予約が削除されました。"
    redirect_to search_rooms_path
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

    def set_new_reservation
      @reservation = Reservation.new(reservation_params)
      @room = Room.find(params[:reservation][:room_id])
      @reservation.user_id = current_user.id
      @reservation.room_id = @room.id
      if @reservation.count_person
        @reservation.total_cost = ((@reservation.check_out - @reservation.check_in).to_i) * @reservation.count_person * @room.price
      end
    end
end
