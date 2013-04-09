class PrimaryDocumentsController < ApplicationController
  # GET /primary_documents
  # GET /primary_documents.json
  def index
    @primary_documents = PrimaryDocument.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @primary_documents }
    end
  end

  # GET /primary_documents/1
  # GET /primary_documents/1.json
  def show
    @primary_document = PrimaryDocument.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @primary_document }
    end
  end

  # GET /primary_documents/new
  # GET /primary_documents/new.json
  def new
    @primary_document = PrimaryDocument.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @primary_document }
    end
  end

  # GET /primary_documents/1/edit
  def edit
    @primary_document = PrimaryDocument.find(params[:id])
  end

  # POST /primary_documents
  # POST /primary_documents.json
  def create
    @primary_document = PrimaryDocument.new(params[:primary_document])

    respond_to do |format|
      if @primary_document.save
        format.html { redirect_to @primary_document, notice: 'Primary document was successfully created.' }
        format.json { render json: @primary_document, status: :created, location: @primary_document }
      else
        format.html { render action: "new" }
        format.json { render json: @primary_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /primary_documents/1
  # PUT /primary_documents/1.json
  def update
    @primary_document = PrimaryDocument.find(params[:id])

    respond_to do |format|
      if @primary_document.update_attributes(params[:primary_document])
        format.html { redirect_to @primary_document, notice: 'Primary document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @primary_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /primary_documents/1
  # DELETE /primary_documents/1.json
  def destroy
    @primary_document = PrimaryDocument.find(params[:id])
    @primary_document.destroy

    respond_to do |format|
      format.html { redirect_to primary_documents_url }
      format.json { head :no_content }
    end
  end
end
