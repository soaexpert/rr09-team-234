require 'ultrasphinx'
require 'ultrasphinx/fields'

#Hack to allow Ultrasphinx to work with pagination_find
Ultrasphinx::Search.module_eval do
def first_page
1
end
def last_page
self.page_count
end
def previous_page?
previous_page ? true : false
end
def next_page?
next_page ? true : false
end
end