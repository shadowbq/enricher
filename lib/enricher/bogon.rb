module Enricher
  #
  # Bogons ipv4 allow for both static simple checks and for dynamic full Bogon list checks provided by Team Cymru.
  #
  # >> @@mybogon = Enricher::Bogon.new(:live)^C
  # >> @@mybogon.contains?('205.166.22.1')
  # => true
  # >> @@mybogon = Enricher::Bogon.new(:ipv4)
  # => #<Enricher::Bogon:0x00000002fb0368 @bogon=[0.0.0.0/8, 10.0.0.0/8, 100.64.0.0/10, 127.0.0.0/8, 169.254.0.0/16, 172.16.0.0/12, 192.0.0.0/24, 192.0.2.0/24, 192.168.0.0/16, 198.18.0.0/15, 198.51.100.0/24, 203.0.113.0/24, 224.0.0.0/4, 240.0.0.0/4]>
  # >> @@mybogon.contains?('205.166.22.1')
  # => false
  #
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
    
    LIST_URL = "http://www.team-cymru.org/Services/Bogons/fullbogons-ipv4.txt"

    def initialize(bogon)
      if bogon == :ipv4
        @bogon = BOGONIPV4.collect do |cidr|
          NetAddr::CIDR.create(cidr)
        end
      elsif bogon == :live
        @bogon = []
        Net::HTTP.get(URI.parse(LIST_URL)).each_line do |line|
          if line !~ /^#/
            @bogon << NetAddr::CIDR.create(line.strip)
          end
        end
      else
        raise BogonSetUndefined, "Only the :ipv4 aggregated set, and :live via http is defined at this time. illegal use of #{bogon}"
      end

      @bogon
    end  
   
    def contains?(ip)
      @bogon.each { |net| return true if net.contains?(ip) }
      return false
    end
   
    def addresses
      @bogon ||= self.initialize
    end

  end

end