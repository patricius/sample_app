require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "Sign up Page" do
    before { visit signup_path }
    let(:submit) { "create my account" }
    it { should have_content("Register") }
    it { should have_button('create my account') }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",       with: "Vijay Meena"
        fill_in "Email",      with: "vijay.meena@gmail.com"
        fill_in "Password",   with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "Profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_selector('h1', text: user.name) }
    it { should have_title(full_title(user.name)) }
  end
end