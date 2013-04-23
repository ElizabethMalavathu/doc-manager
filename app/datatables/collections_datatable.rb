class CollectionsDatatable
  delegate :params, :h, :link_to, :collection_path, :edit_collection_path, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Collection.count,
      iTotalDisplayRecords: collections.total_entries,
      aaData: data
    }
  end

private

  def data
    collections.map do |collection|
      [
        link_to(collection.name, collection),
        h(collection.description),
        h(collection.created_at.strftime("%B %e, %Y")),
        link_to("Get PDF", collection_path(collection, :format => :pdf),  :target => "_blank"),
        link_to('Edit', edit_collection_path(collection), :class => 'btn btn-mini'),
        link_to('Destroy', collection, method: :delete, data: { confirm: 'Are you sure?' }, :class => 'btn btn-mini btn-danger')
      ]
    end
  end

  def collections
    @collections ||= fetch_collections
  end

  def fetch_collections
    collections = Collection.order("#{sort_column} #{sort_direction}")
    collections = collections.page(page).per_page(per_page)
    if params[:sSearch].present?
      collections = collections.where("name like :search or description like :search", search: "%#{params[:sSearch]}%")
    end
    collections
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[created_at name id]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end