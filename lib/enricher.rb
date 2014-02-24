#STDLIBS
require 'uri'
require 'ipaddr'
require 'logger'
require 'rubygems'
require 'tempfile'

# RubyGems

require 'json'
require 'geoip'
require 'netaddr'

# Internal 
module Enricher
  $:.unshift(File.dirname(__FILE__))
  require 'enricher/version'
  require 'enricher/bogon'
  require 'enricher/encoder'

  DEBUG=false
  LOGGING=false

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
    Enricher::DATA_PATH = File.path("/usr/local/lib/share/enricher")
    if Enricher::LOGGING  
      logfile = Tempfile.new('enricher.log')
      Enricher::LOG_PATH = File.dirname(logfile.path) 
    end   
  end   

  Logger = Logger.new(logfile)
  
end
