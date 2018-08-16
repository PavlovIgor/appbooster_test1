require 'yaml'
require "./lib/boot"

class App
  attr_reader :router

  def initialize
    @router = Router.new(ROUTES)
  end

  def call(env)
    request = Rack::Request.new(env)
    result = router.resolve(request)
    [result.status, result.headers, result.content]
  end

  def self.root
    File.dirname(__FILE__)
  end
end
