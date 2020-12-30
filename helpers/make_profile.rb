require_relative 'search_living'

def make_profile(root)
  profile = {
    living: search_location(root)
  }
end
