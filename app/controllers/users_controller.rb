class UsersController < ApplicationController
  before_action :default_avatar, only: [:profile]
  before_action :authenticate_user!

  def profile
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(configure_account_update_params)
      flash[:notice] = "プロフィールの更新が完了しました。"
    end
  end
  

  def account
    @user = current_user
  end

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :avatar])
  end

  def default_avatar
    if !current_user.avatar.attached?
      current_user.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-avatar-image.png')), filename: 'default-avatar-image.png', content_type: 'image/png')
    end
  end
end
