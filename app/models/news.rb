class News < ActiveRecord::Base
	belongs_to :resource

  validates :resource_id, :title,
  					presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }
  scope :by_resource_id, lambda{ |resource_id| where("resource_id = ?", resource_id) unless resource_id.nil? }

  def self.apiall(data = {})
    news          = self.by_id(data[:id]).by_resource_id(data[:resource_id])
    paginate_news = news.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      news: paginate_news.map{|value| value.construct},
      count: paginate_news.count,
      total: news.count
		}
  end

  def construct
    return {
      id: id,
      resource: handle(resource),
      date: date,
      title: title,
      link: link
    }
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

  def handle(obj)
    obj.present? ? obj.construct : {}
  end

end
