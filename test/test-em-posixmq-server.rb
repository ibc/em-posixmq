#!/usr/bin/ruby

require "rubygems"
require "em-posixmq"


class MyPosixMQ < EM::PosixMQ::Watcher
  def receive_message(message, priority)
    puts "received message '#{message}' with priority #{priority} from the queue"
  end
end

EM.run do
  posix_mq = POSIX_MQ.new "/my_posix_mq", IO::CREAT | IO::RDONLY | IO::NONBLOCK
  EM::PosixMQ.run posix_mq, MyPosixMQ
end