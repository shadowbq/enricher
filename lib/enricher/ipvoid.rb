module Enricher
  #
  # IPVOID ipv4 allow for dynamic checks against the list checks provided by IPVOID.
  #
  class IPVoid

    DISABLED = true

    def self.url_cache
      @@url_cache
    end

    def self.hash_cache
      @@hash_cache
    end

    def initialize(constructor = {})
      
      raise DisabledClassIncluded if DISABLED 
      #First you need to include the correct require files
      APT_KEY = "YOUR API KEY HERE"
      @@hash_cache ||= Vash.new
      @@url_cache ||= Vash.new  
        # Voliate Cache store for 43200 (12hr)
    end
    
    def junk

      # RestClient scrape with Nokogiri.... (nokogiri requires libxml which is native which is not jruby compliant.. )

=begin 
      for ip in open(conf.iplist, "r"):
    url = "http://www.ipvoid.com/scan/%s" % (ip)
    emailBody = emailBody + "IP: "+ip
    resp = requests.get(url)
    string1 = unicodedata.normalize('NFKD', resp.text).encode('ascii','ignore')
    r = string1.translate(string.maketrans("\n\t\r", "   "))
    blacklist = re.search(r'Blacklist Status</td><td><span.+>(\w.+)</span>', r)
    if blacklist != None and blacklist.group(1) == "BLACKLISTED":
         emailBody = emailBody + 'The IP is blacklisted! \n'
         detection = re.search(r'Detection Ratio</td><td>(\d+ / \d+) \(<font', r)
         emailBody = emailBody + 'Detection Ratio was %s \n' % detection.group(1)
         detected_line = re.search(r'\s+<tr><td><img src="(.+)', r)
         detected_sites = re.findall(r'Favicon" />(.+?)</td><td><img src=".+?" alt="Alert" title="Detected!".+?"nofollow" href="(.+?)" title', detected_line.group(1))
         for site in detected_sites:
             emailBody = emailBody + "List Name:" + site[0] + "Url: "+ site[1] + "\n\n"
    else:
         emailBody = emailBody + 'Not blacklisted...\n\n'
=end
    end      


    def hash(hash)
      #To query a hash(sha1/sha256/md5)
      @@hash_cache["vt_#{hash}".to_sym] ||= Uirusu::VTFile.query_report(VT_APT_KEY, hash)
      result = Uirusu::VTResult.new(hash, results)
      result.to_json
    end

    def url(url)

      # Use Base 36 for symbols
      #>> "joe@momma.org".hash.to_s(36)
      #=> "37zed965f04p"
      #>> "http://joe@momma.org".hash.to_s(36)
      #=> "vj36lppwievl"
      #=> Tack on.. vt_ to url converted .hash.to_s(36)

      @@url_cache["vt_#{url.hash.to_s(36)}".to_sym] ||= Uirusu::VTUrl.query_report(VT_APT_KEY, url)
       
      result = Uirusu::VTResult.new(url, results)
      result.to_json
    end


  end

end  