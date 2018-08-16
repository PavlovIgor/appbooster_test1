class MainController < Controller
  def index
    redirect_to "/time"
  end

  def time

    @times = [ Time.now.utc.strftime("UTC: %Y-%m-%d %H:%M:%S") ]

    if params["cities"]

      cities = params["cities"].split(',')

      Timezone::Lookup.config(:geonames) do |c|
       c.username = variables['geonames_user']
      end

      Array(cities).each do |city|

        res = Geokit::Geocoders::OSMGeocoder.geocode(city)

        if res.success
          ll = res.ll.split(',')

          timezone = Timezone.lookup(ll[0].to_f, ll[1].to_f)
          @times << timezone.utc_to_local(Time.now).strftime("#{city}: %Y-%m-%d %H:%M:%S")
        end
      end

    end
  end
end
