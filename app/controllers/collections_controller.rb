class CollectionsController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json {render json: CollectionsDatatable.new(view_context) }
    end
  end
  
  def show
    @collection = Collection.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf {
        render  :pdf => "#{@collection.id}.pdf",
                :show_as_html => params[:debug],
                :toc    => {:depth => 2}
      }
    end
  end

  def edit
    @collection = Collection.find(params[:id])
  end

  def create
    @collection = Collection.new(params[:collection])

    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: 'Primary collection was successfully created.' }
        format.json { render json: @collection, status: :created, location: @collection }
      else
        format.html { render action: "new" }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @collection = Collection.find(params[:id])

    respond_to do |format|
      if @collection.update_attributes(params[:collection])
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy

    respond_to do |format|
      format.html { redirect_to collections_url }
      format.json { head :no_content }
    end
  end

  private
  def sanitize_for_latex(string)
    %w[# $ % ^ & _ { } ~ \\].each do |c|
      string.gsub!(c, "\\#{c}")
    end
    string
  end
end
