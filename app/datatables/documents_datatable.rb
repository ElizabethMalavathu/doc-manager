class DocumentsDatatable
  delegate :params, :h, :link_to, :document_path, :edit_document_path, :check_box_tag, to: :@view

  COLUMNS = %w[title location content publication_date]

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
        check_box_tag("document_ids[]", doc.id),
        link_to(doc.title, doc),
        truncated(doc, :location, 100),
        truncated(doc, :content, 100),
        doc.publication_date ? doc.publication_date.strftime("%m/%d/%Y") : "",
        link_to('PDF', document_path(doc, :format => :pdf, :debug => "true"), :class => 'btn btn-mini', :target => "_blank"),
        link_to('Edit', edit_document_path(doc), :class => 'btn btn-mini'),
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
    documents = Document.order("#{sort_column} #{sort_direction}").includes(:collections)
    documents = search_columns(documents)
    documents = documents.page(page).per_page(per_page)
    if params[:sSearch].present?
      documents = documents.where("LOWER(title) like :search or LOWER(content) like :search", search: "%#{params[:sSearch].downcase}%")
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
    columns = %w[publication_date id]
    columns[params[:iSortCol_0].to_i] || "publication_date"
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def intepret_column_filters
    search_values = params.keys.select {|k| k.to_s.include?("sSearch")}
    search_hash = {}
    search_values.each do |v|
      i = v.match(/[0-9]/).to_s.to_i - 1
      if COLUMNS[i] && !params[v].blank?
        search_hash[COLUMNS[i].to_sym] = params[v]
      end
    end

    # Turn publication date into range
    if search_hash[:publication_date] != params["sRangeSeparator"]
      dates = search_hash[:publication_date].split(params["sRangeSeparator"]).map{|d| Date.strptime(d, "%m/%d/%Y") }
      search_hash[:publication_date] = dates.first..dates.last
    else
      search_hash.delete(:publication_date)
    end

    # Turn collection name into an ID
    if search_hash[:collection_name]
      collection = Collection.find_by_name(search_hash[:collection_name])
      search_hash[:collection_id] = collection.id if collection
      search_hash.delete(:collection_name)
    end
    search_hash
  end

  def search_columns(documents)
    search_hash      = intepret_column_filters
    collection_id    = search_hash.delete(:collection_id)
    publication_date = search_hash.delete(:publication_date)

    like_queries = []
    search_hash.each do |column, value|
      like_queries << "LOWER(#{column}) LIKE :#{column}"
      search_hash[column] = "%#{value.downcase}%"
    end
    documents = documents.where(like_queries.join(" AND "), search_hash)
    documents = documents.where(:publication_date => publication_date) if publication_date
    documents = documents.where(:id => Reference.where(:collection_id => collection_id).map(&:document_id)) if collection_id
    documents
  end

end
