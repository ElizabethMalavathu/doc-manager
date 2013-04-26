class CollectionsController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json {render json: Collection.all }
    end
  end
  
  def show
    @collection = Collection.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf {
        render  :pdf => "#{@collection.id}.pdf",
                :show_as_html => params[:debug]
                # :header => {:right => '[page]', :font_name => "Sylfaen" }
                # :toc    => {:depth => 1, :font_name => "Sylfaen"}
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

  def datatable
    respond_to do |format|
      format.json {render json: CollectionsDatatable.new(view_context) }
    end
  end

  def order
    @collection = Collection.find(params[:id])
    @references = @collection.references.order('position ASC').includes(:document)
  end

  def reorder
    params[:references].each do |id, position|
      Reference.find(id).update_attributes(:position => position)
    end
    redirect_to order_collection_path(:id => params[:id])
  end
end
