## Readme

IPv4 Data Enricher

### Static Calculators:

Calculate Maxmind ASN, CC3, Bogon inclusion, and geodata such as Lat Long. 

### Online Calculators:

BGP Ranking with http://bgpranking.circl.lu/ ASN Calculator

Full Bogon Checking with Team Cymru List


### Usage

```
>> require 'enricher'
=> true

>> a = Enricher::Encoder.encode('10.48.185.173')
=> {:ip=>170965421, :asn=>"--", :asn_rank=>"0.0", :geoip=>"--", :bogon=>true}

>> a = Enricher::Encoder.encode('108.48.185.173')
=> {:ip=>1815132589, :asn=>"AS701", :asn_rank=>"0.000011", :geoip=>"USA", :bogon=>false}
```

### Use of Volatile Hash DB

BGP Scores are stored for 12 hours in a volatile hash cache.

```
>> Enricher::BGPRanking.cache
```

### TODO

* IPv4 reputation with VOIDIP
* IPv4 reputation with VirusTotal (uirusu)

## Requirements

Intenet connectivity for Online Calculators.

Maxmind dat file location requirement: `/usr/local/lib/share/enricher`

You need to download and install each of the free GeoLite country, city or ASN databases, or a subscription database version. 

The last known download locations for the GeoLite database versions are:

<geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz>
<geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz>
<geolite.maxmind.com/download/geoip/database/asnum/GeoIPASNum.dat.gz>


## Automating the update of Static Content (via crontrab)

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
