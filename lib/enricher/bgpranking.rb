module Enricher
  #
  # BGP dynamic ASN ranking checks provided by circl.lu.
  #
  # Results cached locally for 12hr. 
  #
  # >  r = RestClient.post "http://bgpranking.circl.lu/json", { 'method' => 'cached_daily_rank', 'asn' => 198540, 'date' => '2014-02-23' }.to_json, :content_type => :json, :accept => :json
  # => "[198540, "ELAN-AS Przedsiebiorstwo Uslug Specjalistycznych ELAN mgr inz. Andrzej Niechcial", "2014-02-23", "global", 1.0496093750000002]"
  # >>  r = RestClient.post "http://bgpranking.circl.lu/json", { 'method' => 'cached_daily_rank', 'asn' => 198540, 'date' => '2014-02-24' }.to_json, :content_type => :json, :accept => :json
  # => "[198540, "ELAN-AS Przedsiebiorstwo Uslug Specjalistycznych ELAN mgr inz. Andrzej Niechcial", "2014-02-24", "global", 1.09609375]"
  # >>  a = JSON.parse(r)
  class BGPRanking

    BGP_RANK_URL = "http://bgpranking.circl.lu/json"

    def self.rank?(addr)
      asn = addr.strip[/[0-9]+/]  
      if asn =~ /[0-9]+/
        @@cache ||= Vash.new 
        # Voliate Cache store for 43200 (12hr)
        @@cache["asn#{asn}".to_sym] ||= self.onlinerank?(asn)
      else
        return "0.0"
      end
    end

    def self.cache
      @@cache
    end

    private

    def self.onlinerank?(addr)
      resp = RestClient.post BGP_RANK_URL, { 'method' => 'cached_daily_rank', 'asn' => addr, 'date' => Date.strptime((Date.today - 1).to_s, '%Y-%m-%d').to_s }.to_json, :content_type => :json, :accept => :json
      return "%.6f" % JSON.parse(resp)[4] 
    end

  end
end