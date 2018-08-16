require 'figaro'

class MainController < Controller
  def index
    @time = Time.now.utc.strftime "UTC: %Y-%m-%d %H:%M:%S"
  end

  def time
    Figaro.application.path = File.join(App.root, 'config', 'application.yml')
    Figaro.load

    @times = [ Time.now.utc.strftime("UTC: %Y-%m-%d %H:%M:%S") ]

    if params["cities"]

      cities = params["cities"].split(',')

      Array(cities).each do |city|
        Timezone::Lookup.config(:geonames) do |c|
         c.username = Figaro.env.geonames_user
        end

        res = Geokit::Geocoders::OSMGeocoder.geocode(city)

        if res.success
          ll = res.ll.split(',')

          timezone = Timezone.lookup(ll[0].to_f, ll[1].to_f)
          @times << timezone.utc_to_local(Time.now).strftime("#{city}: %Y-%m-%d %H:%M:%S")
        end
      end
    @times

    end
  end
end
