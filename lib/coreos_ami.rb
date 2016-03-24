require 'coreos_ami/version'
require 'net/http'
require 'json'

class CoreOS
  DEFAULTS = {
    release: :current,
    virtualization: :hvm,
    region: ENV['AWS_DEFAULT_REGION'] || ENV['AWS_REGION'] || 'us-east-1'
  }

  def initialize(channel = :stable)
    @channel = channel
  end

  def self.channel(channel_name)
    new(channel_name)
  end

  def base_url
    "http://#{@channel}.release.core-os.net/amd64-usr"
  end

  def get(uri)
    begin
      Net::HTTP.get_response(URI.parse(uri)).body.chomp
    rescue => e
      raise "Error with coreos url: #{uri}: #{e.message}"
    end
  end

  ## return hash of all AMIs for release version
  def amis(opt = {})
    args = parse opt
    path = [ base_url, args[:release].to_s, 'coreos_production_ami_all.json' ].join('/')
    JSON.parse(get(path))
  end

  ## return AMI name as string
  def ami(opt = {})
    args = parse opt
    path = [ base_url, args[:release].to_s, "coreos_production_ami_#{args[:virtualization]}_#{args[:region]}.txt" ].join('/')
    get(path)
  end

  private

  def parse(opt)
    DEFAULTS.merge(opt) { |_, from_default, from_opt| from_opt || from_default }
  end
end
