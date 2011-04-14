# -*- coding: utf-8 -*-
# -------------------------------------------------------------------------
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
#
# -------------------------------------------------------------------------

require File.expand_path(File.dirname(__FILE__) + '/../rspec_helper')

describe "Test Parsing with Nokogiri" do
  include Sem4rSpecHelper


#  it "ddd" do
#    pending "test"
#    xml_document = read_xml_document("services", "ad_group_ad", "mutate_add_two_criterions-res.xml")
#    els = xml_document.xpath("//mutateResponse/rval/value/ad/id")
#    els.each {|e| puts e.text.strip.to_i }
#  end

  it "test_account_get_client_accounts" do
    xml_document = read_xml_document("v13_account", "get_client_accounts-res.xml")
    els = xml_document.xpath("//getClientAccountsReturn")
    els.length.should == 5
  end

  it "test_campaign_get" do
    xml_document = read_xml_document("campaign", "get-res.xml")
    rval = xml_document.xpath("//getResponse/rval").first
    els = rval.xpath("entries")
    els.each do |el|
      name = el.at_xpath("name").text.strip
      name.should match /sem4r campaign/
    end

  end

  it "test_adgroup_criterion_get" do
    xml_document = read_xml_document("ad_group_criterion", "get-res.xml")
    rval = xml_document.xpath("//getResponse/rval").first

    el = rval.xpath("entries/criterion[@type='Keyword']").first

    el.at_xpath("id").text.should == "11536082"
    el.at_xpath("text").text.should == "pippo"
    el.at_xpath("matchType").text.should == "BROAD"
  end

  it "test_info_get" do
    xml_document = read_xml_document("info", "get_unit_count-res.xml")

    response_header = xml_document.at_xpath("//ResponseHeader")
    response_header.at_xpath("operations").text.strip.should == "1"
    response_header.at_xpath("responseTime").text.strip.should == "291"
    response_header.at_xpath("units").text.strip.should == "1"

    cost = xml_document.at_xpath("//getResponse/rval/cost")
    cost.text.strip.should == "0"
  end

end
