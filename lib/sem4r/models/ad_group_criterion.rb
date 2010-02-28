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
  # http://code.google.com/apis/adwords/v2009/docs/reference/AdGroupCriterionService.AdGroupCriterion.html
  #
  class AdGroupCriterion
    include SoapAttributes
    
    g_accessor :criterion

    def initialize(&block)
      instance_eval(&block) if block_given?
    end

    def self.from_element(ad_group, el)
      type =  el.elements["AdGroupCriterion.Type"].text
      klass = Module::const_get(type)
      klass.from_element(ad_group, el)
    end

  end

  class BiddableAdGroupCriterion < AdGroupCriterion

    g_accessor :bids

    def initialize(ad_group, &block)
      @ad_group = ad_group
      instance_eval(&block) if block_given?
    end

    def self.from_element(ad_group, el)
      new(ad_group) do
        criterion Criterion.from_element(ad_group, el.elements["criterion"])
        bids      AdGroupCriterionBids.from_element(el.elements["bids"])
      end
    end

    def to_xml(tag)
      builder = Builder::XmlMarkup.new
      xml = builder.tag!(tag, "xsi:type" => "BiddableAdGroupCriterion") do |t|
        t.adGroupId   @ad_group.id
        # t.status "ENABLED"
        criterion.to_xml(t)
        @bids.to_xml(t) if @bids
      end
      xml.to_s
    end

    def save
      unless criterion.id
        soap_message =
          criterion.service.ad_group_criterion.create(criterion.credentials, to_xml("operand"))
        criterion.add_counters( soap_message.counters )
        rval = REXML::XPath.first( soap_message.response, "//mutateResponse/rval")
        id = REXML::XPath.match( rval, "value/criterion/id" ).first
        criterion.instance_eval{ @id = id.text.strip.to_i }
      end
      self
    end

  end

  class NegativeAdGroupCriterion < AdGroupCriterion

    def initialize(ad_group, &block)
      @ad_group = ad_group
      instance_eval(&block) if block_given?
    end

    def to_xml(tag)
      builder = Builder::XmlMarkup.new
      xml = builder.tag!(tag, "xsi:type" => "NegativeAdGroupCriterion") do |t|
        t.adGroupId   criterion.ad_group.id
        # t.status "ENABLED"
        criterion.to_xml(t)
      end
      xml.to_s
    end

    def save
      unless criterion.id
        soap_message =
          criterion.service.ad_group_criterion.create(criterion.credentials, to_xml("operand"))
        criterion.add_counters( soap_message.counters )
        rval = REXML::XPath.first( soap_message.response, "//mutateResponse/rval")
        id = REXML::XPath.match( rval, "value/criterion/id" ).first
        criterion.instance_eval{ @id = id.text.strip.to_i }
      end
      self
    end

  end

end