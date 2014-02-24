module Enricher 
  
  class Encoder
    
    def self.aton(a)
      IPAddr.new(a).to_i
    end
      
    def self.ntoa(a)
      IPAddr.new(a, Socket::AF_INET).to_s
    end
  
    def self.encode(ip)
      @@geoASN ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIPASNum.dat")
      @@geoCoder ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIP.dat")
      @@geoCoderCity ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoLiteCity.dat")
      @@bogon ||= Bogon.new(:bogonipv4)
      asn = @@geoASN.asn(ip).number rescue "--"
      {:ip => IPAddr.new(ip).to_i, :asn => asn, :geoip => @@geoCoder.country(ip).country_code3, :bogon => @@bogon.contains?(ip)}
    end
    
    def self.bogon?(ip)
      @@bogon ||= Bogon.new(:bogonipv4)
      return @@bogon.contains?(ip)
    end
    
    def self.asn(ip)
      @@geoASN ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIPASNum.dat")
      return @@geoASN.asn(ip).number rescue "--"
    end
    
    def self.asn_company(ip)
      @@geoASN ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIPASNum.dat")
      return @@geoASN.asn(ip).asn rescue "--"
    end
    
    def self.cc3(ip)
      @@geoCoder ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIP.dat")
      return @@geoCoder.country(ip).country_code3
    end

    def self.latitude(ip)
      @@geoCoderCity ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIP.dat")
      return @@geoCoderCity.city(ip).latitude
    end

    def self.longitude(ip)
      @@geoCoderCity ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIP.dat")
      return @@geoCoderCity.city(ip).longitude
    end


  end

end

