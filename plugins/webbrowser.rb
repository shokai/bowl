meta :description => "open URL on web browser for Mac OSX.",
     :author      => "Sho Hashimoto <hashimoto@shokai.org>"

data do
  field "url", :type => String, :default => "http://shokai.org"
end

call do
  puts cmd = "open #{url}"
  system cmd
end
