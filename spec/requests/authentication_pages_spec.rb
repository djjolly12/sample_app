require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1'), text: "Sign In" }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: "Sign In") }
      it {should have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }

        it { should_not have_selector('div.alert.alert-error') }
      end

    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_selector('title', text: user.name) }
      it { should have_link('Users', href: users_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user))}
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end


      describe "authorization" do

        describe " for non-signed in users" do
          let(:user) { FactoryGirl.create(:user) }

          describe "looking for unavailable links" do
            describe "profile link should not be present" do
              it { should_not have_link('Profile') }
            end
            describe "settings link should not be present" do
              it { should_not have_link('Settings') }
            end
          end


          describe "when attempting to visit a protected page" do
            before do
              visit edit_user_path(user)
              fill_in "Email", with: user.email
              fill_in "Password", with: user.password
              click_button "Sign in"
            end

            describe "after signing in" do
              it "should render the desired protected page" do
                page.should have_selector('title', text: 'Edit user')
              end
            end
          end
        end

        describe "for non-signed in users" do
          let(:user) { FactoryGirl.create(:user) }

          describe "in the Users controller" do
            describe "visiting the edit page" do
              before { visit edit_user_path(user) }
              it { should have_selector('title', text: 'Sign In') }
            end

            describe "accessing the main user listing" do
              before { visit user_path(user) }
              it { should have_selector('title', text: 'Sign In') }
            end

            describe "submitting to the update action" do
              before { put user_path(user) }
              specify { response.should redirect_to(signin_path) }
            end

            describe "visiting the users index" do
              before { visit users_path }
              it { should have_selector('title', text: 'Sign In') }
            end

            describe " in the microposts controller" do

              describe "submitting to the create action" do
                before { post microposts_path }
                specify { response.should redirect_to(signin_path) }
              end

              describe "submitting to the destroy action" do
                before { delete micropost_path(FactoryGirl.create(:micropost)) }
                specify { response.should redirect_to(signin_path) }

              end
            end
        end

        describe "as wrong user" do
          let(:user) { FactoryGirl.create(:user) }
          let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
          before { sign_in user }

          describe "visiting Users#edit page" do
            before { visit edit_user_path(wrong_user) }
            it { should_not have_selector('title', text: full_title('Edit user')) }
          end

          describe "submitting a PUT request to the User#update action" do
            before { put user_path(wrong_user) }
            specify { response.should redirect_to(root_path) }

          end
        end
        end

        describe "as a non-admin user" do
          let(:user) { FactoryGirl.create(:user) }
          let(:non_admin) { FactoryGirl.create(:user) }

          before {sign_in non_admin}

          describe "submitting a DELETE request to the Users#destroy action" do
            before { delete user_path(user) }
            specify { response.should redirect_to(root_path) }
          end
        end
    end
  end
end
