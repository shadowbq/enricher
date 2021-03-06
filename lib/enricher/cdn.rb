module Enricher
  #
  # Bogons ipv4 allow for both static simple checks and for dynamic full Bogon list checks provided by Team Cymru.
  #
  # CDN List provided by - (23 Dec 2014) https://github.com/WPO-Foundation/webpagetest/blob/master/agent/wpthook/cdn.h
  #
  class CDN
    
    CDN_PROVIDERS = [
      [".akamai.net", "Akamai"],
      [".akamaiedge.net", "Akamai"],
      [".akamaihd.net", "Akamai"],
      [".edgesuite.net", "Akamai"],
      [".edgekey.net", "Akamai"],
      [".srip.ne", "Akamai"],
      [".akamaitechnologies.com", "Akamai"],
      [".akamaitechnologies.fr", "Akamai"],
      [".llnwd.net", "Limelight"],
      ["edgecastcdn.net", "Edgecast"],
      [".systemcdn.net", "Edgecast"],
      [".transactcdn.net", "Edgecast"],
      [".v1cdn.net", "Edgecast"],
      [".v2cdn.net", "Edgecast"],
      [".v3cdn.net", "Edgecast"],
      [".v4cdn.net", "Edgecast"],
      [".v5cdn.net", "Edgecast"],
      ["hwcdn.net", "Highwinds"],
      [".simplecdn.net", "Simple CDN"],
      [".instacontent.net", "Mirror Image"],
      [".footprint.net", "Level 3"],
      [".ay1.b.yahoo.com", "Yahoo"],
      [".yimg.", "Yahoo"],
      [".yahooapis.com", "Yahoo"],
      [".google.", "Google"],
      ["googlesyndication.", "Google"],
      ["youtube.", "Google"],
      [".googleusercontent.com", "Google"],
      ["googlehosted.com", "Google"],
      [".gstatic.com", "Google"],
      [".insnw.net", "Instart Logic"],
      [".inscname.net", "Instart Logic"],
      [".internapcdn.net", "Internap"],
      [".cloudfront.net", "Amazon CloudFront"],
      [".netdna-cdn.com", "NetDNA"],
      [".netdna-ssl.com", "NetDNA"],
      [".netdna.com", "NetDNA"],
      [".cotcdn.net", "Cotendo CDN"],
      [".cachefly.net", "Cachefly"],
      ["bo.lt", "BO.LT"],
      [".cloudflare.com", "Cloudflare"],
      [".afxcdn.net", "afxcdn.net"],
      [".lxdns.com", "ChinaNetCenter"],
      [".att-dsa.net", "AT&T"],
      [".vo.msecnd.net", "Windows Azure"],
      [".voxcdn.net", "VoxCDN"],
      [".bluehatnetwork.com", "Blue Hat Network"],
      [".swiftcdn1.com", "SwiftCDN"],
      [".cdngc.net", "CDNetworks"],
      [".gccdn.net", "CDNetworks"],
      [".panthercdn.com", "CDNetworks"],
      [".fastly.net", "Fastly"],
      [".nocookie.net", "Fastly"],
      [".gslb.taobao.com", "Taobao"],
      [".gslb.tbcache.com", "Alimama"],
      [".mirror-image.net", "Mirror Image"],
      [".yottaa.net", "Yottaa"],
      [".cubecdn.net", "cubeCDN"],
      [".r.cdn77.net", "CDN77"],
      [".incapdns.net", "Incapsula"],
      [".bitgravity.com", "BitGravity"],
      [".r.worldcdn.net", "OnApp"],
      [".r.worldssl.net", "OnApp"],
      ["tbcdn.cn", "Taobao"],
      [".taobaocdn.com", "Taobao"],
      [".ngenix.net", "NGENIX"],
      [".pagerain.net", "PageRain"],
      [".ccgslb.com", "ChinaCache"],
      ["cdn.sfr.net", "SFR"],
      [".azioncdn.net", "Azion"],
      [".azioncdn.com", "Azion"],
      [".azion.net", "Azion"],
      [".cdncloud.net.au", "MediaCloud"],
      [".rncdn1.com", "Reflected Networks"],
      [".cdnsun.net", "CDNsun"],
      [".mncdn.com", "Medianova"],
      [".mncdn.net", "Medianova"],
      [".mncdn.org", "Medianova"],
      ["cdn.jsdelivr.net", "jsDelivr"],
      [".nyiftw.net", "NYI FTW"],
      [".nyiftw.com", "NYI FTW"],
      [".resrc.it", "ReSRC.it"],
      [".zenedge.net", "Zenedge"],
      [".lswcdn.net", "LeaseWeb CDN"],  
      [".revcn.net", "Rev Software"],
      [".revdn.net", "Rev Software"],
      [".1e100.net", "Google"]
    ]

    # Expects a hostname string as a variable
    def self.contains?(hostname = "")
      if hostname != "" then 
        CDN_PROVIDERS.each { |cdn_entry| 
          if hostname.match(cdn_entry[0]) then
            return true 
          end  
        }
      end  
      return false
    end

  end
end