require_relative 'search_living'

def make_profile(root_file)
  root = root_file.search('.bi.bj')
  name = root_file.search('title').text
  profile = {
    name: name,
    living: search_location(root)
  }
end
