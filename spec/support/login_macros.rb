module LoginMacros
  def login(user)
    visit '/login'
    within '#login-form' do
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'ログイン'
    end
  end
end
