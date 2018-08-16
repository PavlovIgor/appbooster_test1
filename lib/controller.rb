class Controller
  attr_reader :name, :action, :request
  attr_accessor :status, :headers, :content

  def initialize(request, name: nil, action: nil)
    @name = name
    @action = action
    @request = request
  end

  def call
    send(action)
    self.status = 200
    self.headers = {"Content-Type" => "text/html"}
    self.content = [template.render(self)]
    self
  end

  def not_found
    self.status = 404
    self.headers = {}
    self.content = ["Nothing found"]
    self
  end

  def internal_error
    self.status = 500
    self.headers = {}
    self.content = ["Internal error"]
    self
  end

  private

  def params
    request.params
  end

  def template
    Slim::Template.new(File.join(App.root,
                                'app',
                                'views',
                                "#{self.name}",
                                "#{self.action}.slim"))
  end

end
