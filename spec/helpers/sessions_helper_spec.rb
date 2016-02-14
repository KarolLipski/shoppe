require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  describe "admin checks" do
    it 'is false if user is not logged' do
      expect(helper.logged_admin?).to eq false
    end
    it 'is false if loged user is not admin' do
      user = FactoryGirl.create(:user)
      helper.log_in(user)
      expect(helper.logged_admin?).to eq false
    end
    it 'is true if loged user is admin' do
      user = FactoryGirl.create(:user, admin: true)
      helper.log_in(user)
      expect(helper.logged_admin?).to eq true
    end
  end
  describe "log_in" do
    it 'stores user id in session' do
      user = FactoryGirl.create(:user)
      helper.log_in(user)
      expect(session[:user_id]).to eq user.id
    end
  end
  describe "log_out" do
    it 'destroy session' do
      user = FactoryGirl.create(:user)
      helper.log_in(user)
      helper.log_out
      expect(session.key?(:user_id)).to eq false
    end
  end
  describe "current_user" do
    it 'returns user object' do
      user = FactoryGirl.create(:user)
      helper.log_in(user)
      expect(helper.current_user).to eq(user)
    end
    it 'return nil when there is no user' do
      expect(helper.current_user).to eq nil
    end
  end
  describe "logged_in?" do
    it 'returns true if user is logged' do
      user = FactoryGirl.create(:user)
      helper.log_in(user)
      expect(helper.logged_in?).to eq true
    end
    it 'returns false if user is not logged' do
      expect(helper.logged_in?).to eq false
    end
  end

end
