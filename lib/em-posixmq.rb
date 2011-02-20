require "eventmachine"
require "posix_mq"


module EventMachine::PosixMQ

  class Watcher < EM::Connection
    def initialize(posix_mq)
      @posix_mq = posix_mq
      @posix_mq.nonblock = true
    end

    def notify_readable
      begin
        message, priority = @posix_mq.receive
        receive_message message, priority
      rescue Errno::EAGAIN
      end
    end

    def receive_message(message, priority)
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
