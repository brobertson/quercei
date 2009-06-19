require 'test_helper'

class SubdocsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:subdocs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_subdoc
    assert_difference('Subdoc.count') do
      post :create, :subdoc => { }
    end

    assert_redirected_to subdoc_path(assigns(:subdoc))
  end

  def test_should_show_subdoc
    get :show, :id => subdocs(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => subdocs(:one).id
    assert_response :success
  end

  def test_should_update_subdoc
    put :update, :id => subdocs(:one).id, :subdoc => { }
    assert_redirected_to subdoc_path(assigns(:subdoc))
  end

  def test_should_destroy_subdoc
    assert_difference('Subdoc.count', -1) do
      delete :destroy, :id => subdocs(:one).id
    end

    assert_redirected_to subdocs_path
  end
end
