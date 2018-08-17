require 'yaml'
require "./lib/boot"

class App
  attr_reader :router, :settings

  def initialize
    @router = Router.new(ROUTES)
    @settings = Settings.new(VARIABLES)
  end

  def call(env)
    request = Rack::Request.new(env)
    result = router.resolve(request, settings.variables)
    [result.status, result.headers, result.content]
  end

  def self.root
    File.dirname(__FILE__)
  end
end
