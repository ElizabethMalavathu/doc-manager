module CollectionsHelper
  def truncated(obj, attribute, length)
    data = obj.send(attribute)
    data and data.size > length ? "#{data[0...length]}..." : data
  end
end
