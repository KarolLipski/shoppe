module UsersHelper

  def welcome_message
    if logged_in?
      return  "Witaj #{current_user.login}"
    else
      return 'Witaj. Zaloguj sie aby miec dostęp do oferty'
    end
  end
end
