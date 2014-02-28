module Enricher
  #
  # Bogons ipv4 allow for both static simple checks and for dynamic full Bogon list checks provided by Team Cymru.
  #
  class VirusTotal

    def self.url_cache
    	@@url_cache
    end

    def self.hash_cache
    	@@hash_cache
    end

  	def initialize(constructor = {})
		#First you need to include the correct require files
		APT_KEY = "YOUR API KEY HERE"
		@@hash_cache ||= Vash.new
		@@url_cache ||= Vash.new  
	    # Voliate Cache store for 43200 (12hr)
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