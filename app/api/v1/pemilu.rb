module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :resources do
      desc "Return list resources"
      get do
        results = Resource.apiall(params)
        {
          results: results
        }
      end
    end

    resource :news do
      desc "Return list news"
      get do
        results = News.apiall(params)
        {
          results: results
        }
      end
    end
  end
end