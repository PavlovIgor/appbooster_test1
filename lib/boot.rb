Dir[File.join(File.dirname(__FILE__),
    '..',
    'lib',
    '*.rb')].each {|file| require file }

Dir[File.join(File.dirname(__FILE__),
    '..',
    'app',
    '**',
    '*.rb')].each {|file| require file }

ROUTES = YAML.load( File.read(File.join(File.dirname(__FILE__),
                    '..',
                    'app',
                    'routes.yml')))

VARIABLES = YAML.load( File.read(File.join(File.dirname(__FILE__),
                    '..',
                    'config',
                    'application.yml')))
