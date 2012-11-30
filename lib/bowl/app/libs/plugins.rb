class Plugin

  def self.dirs
    @@dirs
  end

  def self.dirs
    @@dirs ||= [File.expand_path('../plugins', File.dirname(__FILE__)),
                "#{ENV['HOME']}/.bowl/plugins"]
  end

  def self.list
    @@list ||=
      (
       h = {}
       self.dirs.each do |d|
         FileUtils.mkdir_p d unless File.exists? d
         Dir.glob(File.expand_path '*.rb', d).each do |rb|
           name = rb.scan(/([^\/]+)\.rb$/)[0][0]
           h[name] = rb
         end
       end
       h
       )
  end

  include EventEmitter
  attr_reader :name, :fields

  def initialize(name)
    @name = name
    @meta = {}
    @options = Hash.new(false)
    @fields = Hash.new{|h,k|
      h[k] = {
        :name => nil,
        :index => lambda{ @fields.keys.size }.call,
        :type => String,
        :default => nil,
        :value => nil
      }
    }
    __code = nil
    open(self.class.list[name]) do |f|
      __code = f.read
    end
    raise IOError, "cannot read plug-in file \"#{name}\"" unless __code
    instance_eval __code
  end

  def meta(meta=nil)
    if meta.kind_of? Hash
      @meta = meta
    else
      return @meta
    end
  end

  def set(k,v)
    @options[k.to_sym] = v
  end

  def get(k)
    @options[k.to_sym]
  end

  def data(&block)
    raise ArgumentError, 'block not given' unless block_given?
    instance_eval &block
  end

  def call(&block)
    raise ArgumentError, 'block not given' unless block_given?
    this = self
    CometIO.on "plugin_#{name}" do |data, session_id|
      this.fields.each do |name, field|
        data[name] = field[:default] if field[:default] and data[name].to_s.empty?
      end
      this.instance_variables.each do |name|
        name = name.to_s.gsub(/^@/,'')
        next if ['meta','fields'].include? name
        data[name] = this.instance_eval "@#{name}"
      end
      h = Hashie::Mash.new(data)
      if this.get :callback
        def h.callback(data)
          CometIO.push __callback, data if __callback.to_s.size > 0
        end
      end
      h.instance_eval &block
    end
  end

  def field(name, params={})
    if Hashie::Mash.instance_methods.include? name.to_sym
      raise ArgumentError, "field \"#{name}\" is reserved."
    end
    fields[name][:name] = name
    params.each do |k,v|
      fields[name][k] = v
    end
  end

end
