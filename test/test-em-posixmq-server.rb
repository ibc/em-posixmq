#!/usr/bin/ruby

### TMP: Añadimos lib/ (estemos donde estemos) al LOAD_PATH de Ruby.
#lib_dir = File.expand_path(File.join(File.dirname(__FILE__), "../", "lib"))
#$LOAD_PATH.insert(0, lib_dir)

require "em-posixmq"


class MyPosixMQ < EM::PosixMQ::Watcher
  def receive_message(message, priority)
    puts "received message with priority #{priority}: #{message.inspect}"
  end
end


EM.run do
  posix_mq = POSIX_MQ.new "/test-em-posixmq", IO::CREAT | IO::RDONLY | IO::NONBLOCK
  EM::PosixMQ.run posix_mq, MyPosixMQ
end