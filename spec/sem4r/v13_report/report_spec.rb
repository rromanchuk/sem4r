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

require File.expand_path(File.dirname(__FILE__) + '/../../rspec_helper')

describe Report do
  include Sem4rSpecHelper

  before do
    services = stub("services")
    stub_service_report(services)
    @account = stub_account(services)
  end

  it "create should be accept a block" do
    report = Report.new(@account) do
      name                 "Test Report"
      type                 "Structure"
      start_day            "2009-01-01"
      end_day              "2009-01-31"
      aggregation          "Keyword"
      column               "Campaign"
      column               "AdGroup"
      column               "Keyword"
      column               "KeywordTypeDisplay"
    end
    report.id.should == nil
    report.name.should == "Test Report"
    report.type.should == "Structure"
  end

  it "should parse xml (produced by google)" do
    el = read_model("//getAllJobsReturn", "v13_report", "get_all_jobs-res.xml")
    report = Report.from_element(@account, el)
    report.id.should == 11
    report.name.should == "report [11]"
    report.start_day == "2010-02-19-08:00"
    report.status == "Pending"
  end

  it "should build xml (input for google)" do
    report = Report.new(@account) do
      name                 "Test Report"
      type                 "Structure"
      start_day            "2009-01-01"
      end_day              "2009-01-31"
      aggregation          "Keyword"
      column               "Campaign"
      column               "AdGroup"
      column               "Keyword"
      column               "KeywordTypeDisplay"
    end

    expected = read_model("//job", "v13_report", "schedule_report_job-req.xml")
    report.to_xml.should xml_equivalent(expected)
  end

end
