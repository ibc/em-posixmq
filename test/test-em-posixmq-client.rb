#!/usr/bin/ruby

require "posix_mq"
require "securerandom"


posix_mq = POSIX_MQ.new "/test-em-posixmq", IO::CREAT | IO::WRONLY | IO::NONBLOCK

while true do
  message = SecureRandom.hex 6
  priority = SecureRandom.random_number 9

  puts "sending message '#{message}' with priority #{priority} to the queue..."
  posix_mq.send message, priority

  sleep SecureRandom.random_number
end