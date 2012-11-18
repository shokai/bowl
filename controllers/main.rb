before '/*.json' do
  content_type 'application/json'
end

before '/*' do
  @title = 'fishbowl'
end

get '/' do
  haml :index
end
