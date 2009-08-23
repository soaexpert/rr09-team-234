class SearchController < ApplicationController
  def index
        unless params[:q].blank? 
          query = params[:q].strip
        end 
        page  = params[:page] || 1
        filters = {}
        @sphinx_options = {:query => query}
        @search = Ultrasphinx::Search.new(@sphinx_options).run
        @results =  @search.results
  end

end
