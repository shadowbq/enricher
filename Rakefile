#!/usr/bin/env rake
require "bundler/gem_tasks"
require "rake/testtask" 

task :default => [:test]

Rake::TestTask.new do |test|
  test.libs << "test" 
  test.test_files = Dir[ "test/test_*.rb" ]
  test.verbose = true
end

desc 'Fetch the GeoIP Data sets'
task :fetch_geoip_data do 
  `sudo mkdir -p /usr/local/lib/share/enricher`
  `sudo sh -c '/usr/bin/wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz -O /usr/local/lib/share/enricher/GeoIP.dat.gz; /bin/gunzip -f /usr/local/lib/share/enricher/GeoIP.dat.gz'`
  `sudo sh -c '/usr/bin/wget http://geolite.maxmind.com/download/geoip/database/asnum/GeoIPASNum.dat.gz -O /usr/local/lib/share/enricher/GeoIPASNum.dat.gz; /bin/gunzip -f /usr/local/lib/share/enricher/GeoIPASNum.dat.gz'`
  `sudo sh -c '/usr/bin/wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz -O /usr/local/lib/share/enricher/GeoLiteCity.dat.gz; /bin/gunzip -f /usr/local/lib/share/enricher/GeoLiteCity.dat.gz'`
end
