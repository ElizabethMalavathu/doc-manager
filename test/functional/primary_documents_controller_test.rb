require 'test_helper'

class PrimaryDocumentsControllerTest < ActionController::TestCase
  setup do
    @primary_document = primary_documents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:primary_documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create primary_document" do
    assert_difference('PrimaryDocument.count') do
      post :create, primary_document: { background: @primary_document.background, content: @primary_document.content, location: @primary_document.location, publication_date: @primary_document.publication_date, title: @primary_document.title }
    end

    assert_redirected_to primary_document_path(assigns(:primary_document))
  end

  test "should show primary_document" do
    get :show, id: @primary_document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @primary_document
    assert_response :success
  end

  test "should update primary_document" do
    put :update, id: @primary_document, primary_document: { background: @primary_document.background, content: @primary_document.content, location: @primary_document.location, publication_date: @primary_document.publication_date, title: @primary_document.title }
    assert_redirected_to primary_document_path(assigns(:primary_document))
  end

  test "should destroy primary_document" do
    assert_difference('PrimaryDocument.count', -1) do
      delete :destroy, id: @primary_document
    end

    assert_redirected_to primary_documents_path
  end
end
