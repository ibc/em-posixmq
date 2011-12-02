require "eventmachine"
require "posix_mq"

require "em-posixmq/version"
require "em-posixmq/errors"


module EventMachine::PosixMQ

  class Watcher < ::EM::Connection
    def initialize posix_mq
      @posix_mq = posix_mq
      @posix_mq.nonblock = true
    end

    def notify_readable
      # POSIX_MQ#tryreceive returns nil in case there is nothing to read.
      message, priority = @posix_mq.tryreceive
      receive_message message, priority if message
    end

    # This method must be defined in the user's class inherinting this one.
    def receive_message message, priority
      puts "EM::PosixMQ::Watcher#receive_message #{message.inspect}, #{priority.inspect}"
    end
  end

  def self.run posix_mq, handler
    raise ::EM::PosixMQ::Error, "EventMachine is not running" unless ::EM.reactor_running?

    raise ::EM::PosixMQ::Error, "`posix_mq' argument must be a POSIX_MQ instance" unless
      posix_mq.is_a? ::POSIX_MQ
      
    conn = ::EM.watch posix_mq.to_io, handler, posix_mq
    conn.notify_readable = true

    return conn
  end

end
