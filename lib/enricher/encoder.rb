module Enricher 

  class Encoder

    ## Class Methods for the Encoder.. 
    class << self
      alias_method :to_s, :encode

      def encode(ip)
        
        @@geoASN ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIPASNum.dat")
        @@geoCoder ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIP.dat")
        @@geoCoderCity ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoLiteCity.dat")
        @@res ||= Enricher::Resolver.new
        
        @@bogon_type ||= self.bogon_type
        @@bogon ||= Bogon.new(@@bogon_type)
        
        asn = @@geoASN.asn(ip).number rescue "--"
        
        {:ip => IPAddr.new(ip).to_i, :asn => asn, :asn_rank => Enricher::BGPRanking.rank?(asn), :geoip => @@geoCoder.country(ip).country_code3, :bogon => @@bogon.contains?(ip)}
      end
      
      def encode_online(ip)
        @@geoASN ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIPASNum.dat")
        @@geoCoder ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIP.dat")
        @@geoCoderCity ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoLiteCity.dat")
        @@res ||= Enricher::Resolver.new
        
        @@bogon_type ||= self.bogon_type(:live)
        @@bogon ||= Bogon.new(@@bogon_type)
        
        asn = @@geoASN.asn(ip).number rescue "--"
        reverse_hostname = self.reverse(ip) rescue ""

        {:ip => IPAddr.new(ip).to_i, :asn => asn, :asn_rank => Enricher::BGPRanking.rank?(asn), :geoip => @@geoCoder.country(ip).country_code3, :bogon => @@bogon.contains?(ip), :reverse => reverse_hostname, :cdn => self.cdn?(reverse_hostname)}
      end

      def aton(a)
        IPAddr.new(a).to_i
      end
        
      def ntoa(a)
        IPAddr.new(a, Socket::AF_INET).to_s
      end

      def rank?(asn)
        Enricher::BGPRanking.rank?(asn)
      end

      def bogon?(ip)
        @@bogon_type ||= self.bogon_type
        @@bogon ||= Bogon.new(@@bogon_type)
        return @@bogon.contains?(ip)
      end
      
      def bogon_type(bogon_sym=:ipv4)
        bogon_sym
      end

      def asn(ip)
        @@geoASN ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIPASNum.dat")
        return @@geoASN.asn(ip).number rescue "--"
      end
      
      def asn_company(ip)
        @@geoASN ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIPASNum.dat")
        return @@geoASN.asn(ip).asn rescue "--"
      end
      
      def cc3(ip)
        @@geoCoder ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIP.dat")
        return @@geoCoder.country(ip).country_code3
      end

      def latitude(ip)
        @@geoCoderCity ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIP.dat")
        return @@geoCoderCity.city(ip).latitude
      end

      def longitude(ip)
        @@geoCoderCity ||= GeoIP.new("#{Enricher::DATA_PATH}/GeoIP.dat")
        return @@geoCoderCity.city(ip).longitude
      end

      def reverse(ip)
        @@res ||= Enricher::Resolver.new
        return @@res.reverse?(ip)
      end

      def cdn?(hostname)
        return Enricher::CDN.contains?(hostname) 
      end

    end

  end

end