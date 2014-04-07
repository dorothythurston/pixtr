class ImageSearcher
  def initialize(query)
    @query = query
  end

  def images
    Image.where("name ilike ? OR description ilike ? OR id in (?)",  "%#{query}%", "%#{query}%", image_ids_from_tags)
  end

  private

  attr_reader :query

  def image_ids_from_tags
    Image.tagged_with(query, wild: true).pluck(:id)
  end
end
