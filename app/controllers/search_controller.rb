class SearchController < ApplicationController
   cattr_reader :per_page
   @@per_page = 5 
  def index    
        unless params[:q].blank? 
          query = params[:q].strip
        end     
        filters = {}
        @sphinx_options = {:query => query,:page => params[:page] || 1, :per_page => 20}
        @search = Ultrasphinx::Search.new(@sphinx_options).run
        @total_entries = @search.total_entries
        @results =  @search.results
  end

end
