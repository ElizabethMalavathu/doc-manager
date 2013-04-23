require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  setup do
    @document = Factory.build(:document)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create document" do
    assert_difference('Document.count') do
      post :create, document: { background: @document.background, content: @document.content, location: @document.location, publication_date: @document.publication_date, title: @document.title }
    end

    assert_redirected_to document_path(assigns(:document))
  end

  test "should show document" do
    get :show, id: @document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @document
    assert_response :success
  end

  test "should update document" do
    put :update, id: @document, document: { background: @document.background, content: @document.content, location: @document.location, publication_date: @document.publication_date, title: @document.title }
    assert_redirected_to document_path(assigns(:document))
  end

  test "should destroy document" do
    assert_difference('Document.count', -1) do
      delete :destroy, id: @document
    end

    assert_redirected_to documents_path
  end
end
