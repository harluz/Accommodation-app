# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # サインアップ（パスワード登録）、パスワード編集など

  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /users/sign_up
  def new
    super
  end

  # POST /users
  def create
    super
  end
  
  # GET /users/edit
  def edit
    super
  end
  
  # PUT /users
  def update
    super
  end
  
  # DELETE /users
  def destroy
    super
  end
  
  # GET /users/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.　許可するための追加パラメータがある場合は、sanitizerに追加する
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :introduction])
  end

  # If you have extra params to permit, append them to the sanitizer. 許可するための追加パラメータがある場合は、sanitizerに追加する
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :avatar])
  end

  # The path used after sign up. サインアップ後に使用するpath
  def after_sign_up_path_for(resource)
    users_profile_path
  end

  # The path used after sign up for inactive accounts. アクティブでないアカウントのサインアップ後に使用するpath
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
