#!/usr/bin/ruby
# encoding: UTF-8

#
# BigBlueButton open source conferencing system - http://www.bigbluebutton.org/
#
# Copyright (c) 2012 BigBlueButton Inc. and by respective authors (see below).
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation; either version 3.0 of the License, or (at your option)
# any later version.
#
# BigBlueButton is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General Public License along
# with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.
#

require "trollop"
require 'rest-client'
require File.expand_path('../../../lib/recordandplayback', __FILE__)

opts = Trollop::options do
  opt :meeting_id, "Meeting id to archive", :type => String
end
meeting_id = opts[:meeting_id]

logger = Logger.new("/var/log/bigbluebutton/post_publish.log", 'weekly' )
logger.level = Logger::INFO
BigBlueButton.logger = logger

#published_files = "/var/bigbluebutton/published/presentation/#{meeting_id}"
meeting_metadata = BigBlueButton::Events.get_meeting_metadata("/var/bigbluebutton/recording/raw/#{meeting_id}/events.xml")

#
# Put your code here
#
BigBlueButton.logger.info("Starting Downloader")
sleep(600)

begin
  permit_download = meeting_metadata["download"].value
  BigBlueButton.logger.info(permit_download)

  if (permit_download.to_s == "true")
    host = meeting_metadata["bbb-origin-server-name"].value
    BigBlueButton.logger.info(host)
    email = meeting_metadata["email"].value
    BigBlueButton.logger.info(email)
    address = 'http://grav-webconf.virtual.ufc.br?'
    url = 'https://' + host + '/playback/presentation/2.0/playback.html?meetingId=' + meeting_id
    BigBlueButton.logger.info(url)
    resp = RestClient.get "#{address}email=#{email}&url=#{url}"
    BigBlueButton.logger.info("#{address}email=#{email}&url=#{url}")

    BigBlueButton.logger.info(resp.body)
  end

rescue => e
  BigBlueButton.logger.info("Rescued")
  BigBlueButton.logger.info(e.to_s)
end

exit 0
