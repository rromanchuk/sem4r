# -------------------------------------------------------------------
# Copyright (c) 2009-2010 Sem4r sem4ruby@gmail.com
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# -------------------------------------------------------------------

module Sem4r

  #
  # @private
  #
  class TargetingIdeaService < Sem4rSoap::SoapServiceV2010 #:nodoc: all

    def initialize(connector)
      @connector = connector

      @header_namespace  = "https://adwords.google.com/api/adwords/cm/v201008"
      @service_namespace = "https://adwords.google.com/api/adwords/o/v201008"

      @sandbox_service_url    = "https://adwords-sandbox.google.com/api/adwords/o/v201008/TargetingIdeaService"
      @production_service_url = "https://adwords.google.com/api/adwords/o/v201008/TargetingIdeaService"
      init(@header_namespace, @service_namespace)
    end

    soap_call :get, :mutate => false

    private

    def _get(xml)
      <<-EOFS
      <s:get>#{xml}</s:get>
      EOFS
    end

  end
end
