
helpers do
  def bowl_js
    "#{app_root}/bowl.js"
  end
end

get '/bowl.js' do
  content_type 'application/javascript'
  @js ||= (
           js = nil
           File.open(File.expand_path '../js/bowl.js', File.dirname(__FILE__)) do |f|
             js = f.read
           end
           ERB.new(js).result(binding)
           )
end
