class UsersController < ApplicationController
  before_action :default_avatar, only: [:profile, :update]
  before_action :authenticate_user!
  before_action :set_user,

  def profile
  end

  def edit
  end

  def update
    if @user.update(user_parmas)
      flash[:notice] = "プロフィールの更新が完了しました。"
      redirect_to users_profile_path
    else
      flash[:notice] = "プロフィールの更新に失敗しました。"
      render users_profile_edit_path
    end
  end
  
  def account
  end

  private

  def set_user
    @user = current_user
  end
  

  protected

  def user_parmas
    params.require(:user).permit(:name, :introduction, :avatar)
  end
  

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :avatar])
  end

  def default_avatar
    if !current_user.avatar.attached?
      current_user.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-avatar-image.png')), filename: 'default-avatar-image.png', content_type: 'image/png')
    end
  end
end
