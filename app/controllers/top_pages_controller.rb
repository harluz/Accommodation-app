class TopPagesController < ApplicationController
  before_action :set_q, only: [:top, :search]

  def top
  end

  def search
    @results = @q.result
  end

  private

  def set_q
    @q = Room.ransack(params[:q])
  end
end
