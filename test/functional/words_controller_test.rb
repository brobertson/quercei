require 'test_helper'

class WordsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:words)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_word
    assert_difference('Word.count') do
      post :create, :word => { }
    end

    assert_redirected_to word_path(assigns(:word))
  end

  def test_should_show_word
    get :show, :id => words(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => words(:one).id
    assert_response :success
  end

  def test_should_update_word
    put :update, :id => words(:one).id, :word => { }
    assert_redirected_to word_path(assigns(:word))
  end

  def test_should_destroy_word
    assert_difference('Word.count', -1) do
      delete :destroy, :id => words(:one).id
    end

    assert_redirected_to words_path
  end
end
