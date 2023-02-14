class UsersController < ApplicationController
  before_action :default_avatar, :authenticate_user!

  def profile
    @user = current_user
  end

  protected

  def default_avatar
    if !current_user.avatar.attached?
      current_user.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-avatar-image.png')), filename: 'default-avatar-image.png', content_type: 'image/png')
    end
  end
end
