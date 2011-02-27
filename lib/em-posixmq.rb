require "eventmachine"
require "posix_mq"

require "em-posixmq/version"


module EventMachine::PosixMQ

  class Watcher < EM::Connection
    def initialize(posix_mq)
      @posix_mq = posix_mq
      @posix_mq.nonblock = true
    end

    def notify_readable
      # POSIX_MQ#tryreceive returns nil in case there is nothing to read.
      message, priority = @posix_mq.tryreceive
      receive_message message, priority if message
    end

    def receive_message(message, priority)
      # This method must be defined in the user's class inherinting this one.
    end
  end

  def self.run(posix_mq, handler)
    raise Error, "EventMachine is not running" unless EM.reactor_running?

    raise Error, "`posix_mq' argument must be a POSIX_MQ instance" unless
      posix_mq.is_a? POSIX_MQ
      
    EM.watch posix_mq.to_io, handler, posix_mq do |conn|
      conn.notify_readable = true
    end

    self
  end

end
