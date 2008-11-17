require 'test_helper'

class TreebanksControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:treebanks)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_treebank
    assert_difference('Treebank.count') do
      post :create, :treebank => { }
    end

    assert_redirected_to treebank_path(assigns(:treebank))
  end

  def test_should_show_treebank
    get :show, :id => treebanks(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => treebanks(:one).id
    assert_response :success
  end

  def test_should_update_treebank
    put :update, :id => treebanks(:one).id, :treebank => { }
    assert_redirected_to treebank_path(assigns(:treebank))
  end

  def test_should_destroy_treebank
    assert_difference('Treebank.count', -1) do
      delete :destroy, :id => treebanks(:one).id
    end

    assert_redirected_to treebanks_path
  end
end
