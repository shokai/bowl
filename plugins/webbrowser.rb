
data do
  field "url", :type => String, :default => "http://shokai.org"
end

call do
  puts cmd = "open #{url}"
  system cmd
end
