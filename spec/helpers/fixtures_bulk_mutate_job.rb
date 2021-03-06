# -*- coding: utf-8 -*-
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

module FixtureBulkMutateJob

  def fixtures_bulk_mutate_job
    @dump_interceptor.reset_and_stop
    account = @adwords.account

    campaign, ad_group = template_campaign_and_ad_group(account)

    intercept("mutate-add_job") {
      job = template_bulk_mutate_job(campaign, ad_group)
      job.num_parts = 2 # create a pending job, so it is possible to see in list
      result_job = account.job_mutate(JobOperation.add(job))
      puts result_job.to_s
    }

    intercept("get-list_job") {
      account.p_jobs
    }

    @dump_interceptor.intercept_to("report_definition", "getReportFields-{type}.xml")
    @dump_interceptor.stop
  end

end