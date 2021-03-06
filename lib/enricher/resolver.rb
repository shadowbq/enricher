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
  class Resolver
    
    def initialize(nameservers = ["4.2.2.2","4.2.2.3","4.2.2.4"])
      @res = Net::DNS::Resolver.new
      @res.nameservers = nameservers
    end

    def reverse?(ip)
      begin
        packet = @res.search(ip)
        return packet.answer[0].ptr
      rescue
        return ""
      end
    end

  end
end