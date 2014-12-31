## Readme

IPv4 Data Enricher

[![Gem Version](https://badge.fury.io/rb/enricher.png)](http://badge.fury.io/rb/enricher)

### Static Calculators:

Calculate Maxmind ASN, CC3, Bogon inclusion, and geodata such as Lat Long. 

CDN Hostname check regex lookup.

### Online Calculators:

BGP Ranking with http://bgpranking.circl.lu/ ASN Calculator

Full Bogon Checking with Team Cymru List

Reverse DNS Lookups from (L3 DNS Servers 4.2.2.2/3/4)


### Usage

```
>> require 'enricher'
=> true
```

#### For Pure Offline Meta Data Enhancement
```
>> a = Enricher::Encoder.encode('10.48.185.173')
=> {:ip=>170965421, :asn=>"--", :asn_rank=>"0.0", :geoip=>"--", :bogon=>true}

>> a = Enricher::Encoder.encode('108.48.185.173')
=> {:ip=>1815132589, :asn=>"AS701", :asn_rank=>"0.000011", :geoip=>"USA", :bogon=>false}
```

#### For Online Meta Data Enrichment
```
2.1.2 :006 > a = Enricher::Encoder.encode_online('96.3.8.26')
 => {:ip=>1610811418, :asn=>"AS11232", :asn_rank=>"0.000048", :geoip=>"USA", :bogon=>false, :reverse=>"host-26-8-3-96.midco.net.", :cdn=>false} 
2.1.2 :007 > a = Enricher::Encoder.encode_online('96.6.113.42')
 => {:ip=>1611034922, :asn=>"AS20940", :asn_rank=>"0.000411", :geoip=>"USA", :bogon=>false, :reverse=>"a96-6-113-42.deploy.akamaitechnologies.com.", :cdn=>true} 
2.1.2 :008 > a = Enricher::Encoder.encode_online('119.27.76.185')
 => {:ip=>1998277817, :asn=>"AS4837", :asn_rank=>"0.000082", :geoip=>"CHN", :bogon=>false, :reverse=>"", :cdn=>false} 
2.1.2 :009 > a = Enricher::Encoder.encode_online('199.27.76.185')
 => {:ip=>3340455097, :asn=>"AS54113", :asn_rank=>"0.000526", :geoip=>"USA", :bogon=>false, :reverse=>"", :cdn=>false} 
2.1.2 :010 > a = Enricher::Encoder.encode_online('54.239.195.35')
 => {:ip=>921682723, :asn=>"AS16509", :asn_rank=>"0.000293", :geoip=>"USA", :bogon=>false, :reverse=>"server-54-239-195-35.nrt12.r.cloudfront.net.", :cdn=>true} 
2.1.2 :011 > a = Enricher::Encoder.encode_online('54.239.195.149')
 => {:ip=>921682837, :asn=>"AS16509", :asn_rank=>"0.000293", :geoip=>"USA", :bogon=>false, :reverse=>"server-54-239-195-149.nrt12.r.cloudfront.net.", :cdn=>true} 
2.1.2 :012 > a = Enricher::Encoder.encode_online('72.21.91.8')
 => {:ip=>1209359112, :asn=>"AS15133", :asn_rank=>"0.000312", :geoip=>"USA", :bogon=>false, :reverse=>"", :cdn=>false} 
2.1.2 :013 > a = Enricher::Encoder.encode_online('173.194.121.44')
 => {:ip=>2915203372, :asn=>"AS15169", :asn_rank=>"0.000204", :geoip=>"USA", :bogon=>false, :reverse=>"iad23s26-in-f12.1e100.net.", :cdn=>true} 
2.1.2 :014 > a = Enricher::Encoder.encode_online('205.234.175.175')
 => {:ip=>3454709679, :asn=>"AS30081", :asn_rank=>"0.000781", :geoip=>"USA", :bogon=>false, :reverse=>"vip1.G-anycast1.cachefly.net.", :cdn=>true} 
```

### Use of Volatile Hash DB

BGP Scores are stored for 12 hours in a volatile hash cache.

```
2.1.2 :015 > Enricher::BGPRanking.cache
 => {:asn12542=>"0.000010", :asn11232=>"0.000048", :asn20940=>"0.000411", :asn4837=>"0.000082", :asn54113=>"0.000526", :asn16509=>"0.000293", :asn15133=>"0.000312", :asn15169=>"0.000204", :asn30081=>"0.000781"} 
```

### TODO

* IPv4 reputation with VOIDIP
* IPv4 reputation with VirusTotal (uirusu)

## Requirements

Intenet connectivity is required *only* for Online Meta Data Enhancement.

### BootStrapping GeoIP

There is a rake command include to bootstrap the fetching of geoip data if you are a sudo enabled linux user.

```
(/home/shadowbq/.rvm/gems/ruby-2.1.2/gems/enricher-0.0.7)$ rake fetch_geoip_data
--2014-12-31 11:32:28--  http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
Resolving geolite.maxmind.com (geolite.maxmind.com)... 141.101.115.190, 141.101.114.190, 2400:cb00:2048:1::8d65:72be, ...
Connecting to geolite.maxmind.com (geolite.maxmind.com)|141.101.115.190|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 428181 (418K) [application/octet-stream]
Saving to: ‘/usr/local/lib/share/enricher/GeoIP.dat.gz’

100%[=====================================================================================================================================================================================================================================>] 428,181     --.-K/s   in 0.08s   

2014-12-31 11:32:28 (5.22 MB/s) - ‘/usr/local/lib/share/enricher/GeoIP.dat.gz’ saved [428181/428181]

--2014-12-31 11:32:28--  http://geolite.maxmind.com/download/geoip/database/asnum/GeoIPASNum.dat.gz
Resolving geolite.maxmind.com (geolite.maxmind.com)... 141.101.114.190, 141.101.115.190, 2400:cb00:2048:1::8d65:73be, ...
Connecting to geolite.maxmind.com (geolite.maxmind.com)|141.101.114.190|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 2056964 (2.0M) [application/octet-stream]
Saving to: ‘/usr/local/lib/share/enricher/GeoIPASNum.dat.gz’

100%[=====================================================================================================================================================================================================================================>] 2,056,964   1.38MB/s   in 1.4s   

2014-12-31 11:32:30 (1.38 MB/s) - ‘/usr/local/lib/share/enricher/GeoIPASNum.dat.gz’ saved [2056964/2056964]

--2014-12-31 11:32:30--  http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
Resolving geolite.maxmind.com (geolite.maxmind.com)... 141.101.115.190, 141.101.114.190, 2400:cb00:2048:1::8d65:72be, ...
Connecting to geolite.maxmind.com (geolite.maxmind.com)|141.101.115.190|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 11896864 (11M) [application/octet-stream]
Saving to: ‘/usr/local/lib/share/enricher/GeoLiteCity.dat.gz’

100%[=====================================================================================================================================================================================================================================>] 11,896,864  5.10MB/s   in 2.2s   

2014-12-31 11:32:32 (5.10 MB/s) - ‘/usr/local/lib/share/enricher/GeoLiteCity.dat.gz’ saved [11896864/11896864]

>$ ls -la /usr/local/lib/share/enricher/
total 22664
drwxr-xr-x 2 root root     4096 Dec 31 11:32 .
drwxr-xr-x 3 root root     4096 Dec 31 11:23 ..
-rw-r--r-- 1 root root   748606 Dec  2 16:43 GeoIP.dat
-rw-r--r-- 1 root root  3766172 Dec 12 17:54 GeoIPASNum.dat
-rw-r--r-- 1 root root 18678957 Dec  2 16:57 GeoLiteCity.dat

```

(Manual Methods)

Maxmind(R) dat file location requirement: `/usr/local/lib/share/enricher`

You need to download and install each of the free GeoLite country, city or ASN databases, or a subscription database version. 

The last known download locations for the GeoLite database versions are:

* http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
* http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
* http://geolite.maxmind.com/download/geoip/database/asnum/GeoIPASNum.dat.gz


### Automating the update of Static Content (via crontrab)

We can add a cron-job to automate the monthly process of updating the GeoIP database:

```
 mkdir -p /etc/crontab
```

Now we will add a custom job:

```
 vim /etc/crontab/91_Update_GeoIP_db
```

Add the following to this jopb, this will download and extract the new databases every month:

``` 
 # Updating the GeoIP database monthly on the 5th at 0:00h.
 0 0 5 * * root /usr/bin/wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz -O /usr/local/lib/share/enricher/GeoIP.dat.gz; /bin/gunzip -f /usr/local/lib/share/enricher/GeoIP.dat.gz

 0 0 5 * * root /usr/bin/wget http://geolite.maxmind.com/download/geoip/database/asnum/GeoIPASNum.dat.gz -O /usr/local/lib/share/enricher/GeoIPASNum.dat.gz; /bin/gunzip -f /usr/local/lib/share/enricher/GeoIPASNum.dat.gz

 0 0 5 * * root /usr/bin/wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz -O /usr/local/lib/share/enricher/GeoLiteCity.dat.gz; /bin/gunzip -f /usr/local/lib/share/enricher/GeoLiteCity.dat.gz
```
