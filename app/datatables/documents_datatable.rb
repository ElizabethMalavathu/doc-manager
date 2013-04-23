class DocumentsDatatable
  delegate :params, :h, :link_to, :edit_document_path, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Document.count,
      iTotalDisplayRecords: documents.total_entries,
      aaData: data
    }
  end

private

  def data
    documents.map do |doc|
      [
        link_to(doc.title, doc),
        truncated(doc, :location, 100),
        truncated(doc, :content, 400),
        truncated(doc, :background, 100),
        doc.publication_date,
        link_to('Edit', edit_document_path(doc), :class => 'btn btn-mini'),
        link_to('Destroy', doc, method: :delete, data: { confirm: 'Are you sure?' }, :class => 'btn btn-mini btn-danger')
      ]
    end
  end

  def truncated(obj, attribute, length)
    data = obj.send(attribute)
    data and data.size > length ? "#{data[0...length]}..." : data
  end

  def documents
    @documents ||= fetch_documents
  end

  def fetch_documents
    documents = Document.order("#{sort_column} #{sort_direction}")
    documents = documents.page(page).per_page(per_page)
    if params[:sSearch].present?
      documents = documents.where("title like :search or content like :search", search: "%#{params[:sSearch]}%")
    end
    documents
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[id]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end