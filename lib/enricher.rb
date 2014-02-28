#STDLIBS
require 'uri'
require 'ipaddr'
require 'logger'
require 'rubygems'
require 'tempfile'
require 'net/http'
require 'date'

# RubyGems

require 'json'
require 'geoip'
require 'netaddr'
require 'rest-client'
require 'uirusu'

# Internal 
module Enricher
  $:.unshift(File.dirname(__FILE__))

  require 'vash'
  require 'enricher/version'
  require 'enricher/exceptions'
  require 'enricher/bogon'
  require 'enricher/bgpranking'
  require 'enricher/encoder'
  
  DEBUG=false
  LOGGING=false
  COMMON_DATA_PATHS=[
    '/usr/local/lib/share/enricher', 
    '/usr/local/share/enricher',
    '/usr/local/lib/enricher',
    '/usr/local/etc/enricher',
    '/etc/enricher',
    '/var/db/enricher'
  ]
  
  #Setup Paths
  LIB_PATH = File.expand_path("../", __FILE__)
  CONFIG_PATH = File.expand_path("../../db", __FILE__)
  
  if Enricher::DEBUG
    Enricher::DATA_PATH = File.expand_path("../../data", __FILE__)
    if Enricher::LOGGING
      Enricher::LOG_PATH = File.expand_path("../../log", __FILE__)
      logfile = "#{Enricher::LOG_PATH}/enricher.log"
    end   
  else
    COMMON_DATA_PATHS.each do |dirname| 
      if File.exists?(dirname) && File.directory?(dirname)
        Enricher::DATA_PATH = File.path(dirname)
        if Enricher::LOGGING  
          logfile = Tempfile.new('enricher.log')
          Enricher::LOG_PATH = File.dirname(logfile.path) 
        end
        break 
      else
        raise EnricherPathMissing, "Enricher data path not found in Common Data Paths. "
      end
    end   
  end   

  Logger = Logger.new(logfile)
  
end
