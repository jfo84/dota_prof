require 'httparty'

require_relative 'app/assets/hero_id'

HERO_ID[:result][:heroes].each do |hero|
  File.open("/Users/JRF/my_tools/dota_prof/app/assets/images/heroes/#{hero[:name]}_#{hero[:id]}.jpg", "wb") do |f|
    f.write HTTParty.get("http://cdn.dota2.com/apps/dota2/images/heroes/#{hero[:name]}_sb.png").parsed_response
  end
end
