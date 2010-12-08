#
# soap connection layer
#
require 'net/https'
require 'uri'
require 'open-uri'

require 'sem4r_soap/soap_error'
require 'sem4r_soap/http_connector'
require 'sem4r_soap/soap_dumper'
require 'sem4r_soap/soap_connector'
require 'sem4r_soap/adwords_soap_connector'
require 'sem4r_soap/soap_response'
require 'sem4r_soap/soap_service'
require 'sem4r_soap/soap_service_v13'
require 'sem4r_soap/soap_service_v2010'