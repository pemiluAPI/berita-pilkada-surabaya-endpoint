class Resource < ActiveRecord::Base
	has_many :news

  validates :name,
  					presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }

  def self.apiall(data = {})
    resource          = self.by_id(data[:id])
    paginate_resource = resource.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      resource: paginate_resource.map{|value| value.construct},
      count: paginate_resource.count,
      total: resource.count
		}
  end

  def construct
    return {
      id: id,
      name: name
    }
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

end
