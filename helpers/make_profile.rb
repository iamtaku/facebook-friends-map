require_relative 'search_living'

def make_profile(id, root_file)
  root = root_file.search('.bi.bj')
  name = root_file.search('title').text
  profile = {
    name: name,
    fb_id: id,
    living: search_location(root)
  }
end
