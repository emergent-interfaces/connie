require 'test_helper'

class ConventionsControllerTest < ActionController::TestCase
  context "with a logged in user" do
    setup do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    should "reset session if default convention missing" do
      @convention = FactoryGirl.create(:convention)
      put :set_as_default, :id => @convention.id
      assert session[:default_convention_id]

      @convention.delete
      get :index
      refute session[:default_convention_id]
    end

    context "with a convention" do
      setup do
        @convention = FactoryGirl.create(:convention, :name => "New Convention")
      end

      should "have route to set default convention for session" do
        assert_recognizes({:controller => "conventions", :action => "set_as_default", :id => "#{@convention.id}"},
                          {:path => "conventions/#{@convention.id}/set_as_default", :method => :put})
      end

      should "have a route to set no default convention for session" do
        assert_recognizes({:controller => "conventions", :action => "remove_default"},
                          {:path => "conventions/remove_default", :method => :put})
      end

      should "be able to set default convention" do
        put :set_as_default, :id => @convention.id
        assert :success

        assert_equal @convention.id, session[:default_convention_id]
      end

      should "be able to set no default convention by remove_default" do
        session[:default_convention_id] = 1

        put :remove_default, :id => nil
        assert :success

        assert_nil session[:default_convention_id]
      end
    end

  end
end
