# EM-PosixMQ

EM-PosixMQ integrates [posix_mq](http://bogomips.org/ruby_posix_mq) Ruby library into [EventMachine](http://rubyeventmachine.com), allowing asynchronous reading from a [POSIX message queue](http://linux.die.net/man/7/mq_overview).


## Usage Example

 * Server (reads from a Posix message queue):
 
    require "em-posixmq"
    
    class MyPosixMQ < EM::PosixMQ::Watcher
      def receive_message(message, priority)
        puts "received message with priority #{priority}: #{message.inspect}"
      end
    end

    EM.run do
      posix_mq = POSIX_MQ.new "/my_posix_mq", IO::CREAT | IO::RDONLY | IO::NONBLOCK
      EM::PosixMQ.run posix_mq, MyPosixMQ
    end

 * Client (writes into a Posix message queue):

    require "posix_mq"
    require "securerandom"
    
    posix_mq = POSIX_MQ.new "/test-em-posixmq", IO::CREAT | IO::WRONLY | IO::NONBLOCK, 00660
    
    while true do
      message = SecureRandom.hex 6
      priority = SecureRandom.random_number 9
      
      puts "sending message '#{message}' with priority #{priority} to the queue..."
      posix_mq.send message, priority
      
      sleep SecureRandom.random_number
    end

The client script will write random messages with random priority into a Posix message queue named "/test-em-posixmq" at variable intervals.



## Creating a Handler

In order to use EM-PosixMQ a class handler must be created. Such class must inherit from `EM::PosixMQ::Watcher` and define the method `receive_message` which would be called with two parameters `message` (a `String`) and `priority` (a `Fixnum`) upon receipt of a message in the Posix messaeg queue.

    class MyPosixMQ < EM::PosixMQ::Watcher
      def receive_message(message, priority)
        # do something with the message (and priority).
      end
    end


## Runnig the Server

    EM::PosixMQ.run posix_mq, MyPosixMQ

Attaches the `POSIX_MQ` instance to the EventMachine reactor for asynchronous reading. This method must be called after EventMachine is running.


## Installation

EM-PosixMQ is provided as a Ruby Gem:

    ~$ gem install em-posixmq


## Supported Platforms

EM-PosixMQ depends on [POSIX message queues](http://linux.die.net/man/7/mq_overview) which are implemented in Linux and BSD.


## Acknowledgement

Many thanks to Eric Wong, the author of [posix_mq](http://bogomips.org/ruby_posix_mq) Ruby library.
