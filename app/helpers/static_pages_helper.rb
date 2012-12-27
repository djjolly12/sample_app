module StaticPagesHelper

  def am_i_logged_in
    cur_user = @user
    if cur_user.blank?
      link_text = "Sign up now!"
      rout_path = signup_path
    else
      link_text = "See your friends"
      rout_path = users_path
    end
  end
end
