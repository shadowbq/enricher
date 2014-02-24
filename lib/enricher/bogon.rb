module Enricher
  class Bogon
    
    BOGONIPV4 = ['0.0.0.0/8',
    '10.0.0.0/8',
    '100.64.0.0/10',
    '127.0.0.0/8',
    '169.254.0.0/16',
    '172.16.0.0/12',
    '192.0.0.0/24',
    '192.0.2.0/24',
    '192.168.0.0/16',
    '198.18.0.0/15',
    '198.51.100.0/24',
    '203.0.113.0/24',
    '224.0.0.0/4',
    '240.0.0.0/4']
    
    def initialize(bogon)
      if bogon == :bogonipv4
        @bogon = BOGONIPV4.collect do |cidr|
          NetAddr::CIDR.create(cidr)
        end
      else
        raise BogonSetUndefined, "Only the :bogonipv4 aggregated set is defined at this time"
      end
    end  
   
    def contains?(ip)
      @bogon.each do |net|
        return true if net.contains?(ip)
      end
      return false
    end
    
  end
end