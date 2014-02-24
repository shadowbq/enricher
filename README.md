## Readme

IPv4 Data Enricher

### Static Calculators:

Calculate ASN, CC3, Bogon, and Lat Long. 

### Online Calculators:

IPv4 reputation with VOIDIP
IPv4 reputation with VirusTotal

BGP Ranking with Cyrmu ASN Calculator

## Requirements

Intenet connectivity for Online Calculators.

You need each of the free GeoLite country, city or ASN databases, or a subscription database version. 

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