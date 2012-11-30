
helpers do
  def fishbowl_js
    "#{app_root}/fishbowl.js"
  end
end

get '/fishbowl.js' do
  content_type 'application/javascript'
  @js ||= (
           js = nil
           File.open(File.expand_path '../js/fishbowl.js', File.dirname(__FILE__)) do |f|
             js = f.read
           end
           ERB.new(js).result(binding)
           )
end
