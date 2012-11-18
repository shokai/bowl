
data do
  field "url", :type => String
end

call do
  puts cmd = "open #{url}"
  system cmd
end
