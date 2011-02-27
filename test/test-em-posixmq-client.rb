#!/usr/bin/ruby

require "rubygems"
require "posix_mq"
require "securerandom"


posix_mq = POSIX_MQ.new "/my_posix_mq", IO::CREAT | IO::WRONLY | IO::NONBLOCK

while true do
  message = SecureRandom.hex 6
  priority = SecureRandom.random_number 9

  puts "sending message '#{message}' with priority #{priority} to the queue..."
  unless posix_mq.trysend message, priority
    puts "WARN: cannot write '#{message}' into the queue (full)"
  end

  sleep SecureRandom.random_number
end