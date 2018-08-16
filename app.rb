require 'yaml'
require "./lib/boot"

class App
  attr_reader :router, :variables

  def initialize
    @router = Router.new(ROUTES)
    @variables = VARIABLES
  end

  def call(env)
    request = Rack::Request.new(env)
    result = router.resolve(request, variables)
    [result.status, result.headers, result.content]
  end

  def variables
    @variables
  end

  def self.root
    File.dirname(__FILE__)
  end
end
