class Template
  # attr_accessor :collection
  def initialize(collection)
    @collection = collection
  end

  def to_pdf
    pdf = Prawn::Document.new
    pdf.text "Hello world"
    pdf.move_down 20
    pdf.text @collection.description

    #### Table of Contents ####
    pdf.text "Table of Contents"

    @collection.primary_documents.each_with_index do |doc, index|

    end

    #### Documents ####

    @collection.primary_documents.each do |doc|
      pdf.start_new_page
      pdf.text "title: #{doc.title}"
      pdf.text "location: #{doc.location}"
      pdf.text "background: #{doc.background}"
      pdf.text "publication_date: #{doc.publication_date}"

      # move_down 20
      doc.content.split("\n").each do |paragraph|
        pdf.text paragraph
      end
    end
    pdf
  end
end
