class Bootstrap
  def self.default
    []
  end

  def self.init(*inits)
    [default, inits].flatten.uniq.each do |cat|
      Dir.glob("#{File.dirname(__FILE__)}/#{cat}/*.rb").each do |rb|
        require rb
      end
    end
  end
end
