require "./lib/em-posixmq/version"

Gem::Specification.new do |spec|
  spec.name = "em-posixmq"
  spec.version = EventMachine::PosixMQ::VERSION
  spec.date = Time.now
  spec.authors = ["Iñaki Baz Castillo"]
  spec.email = "ibc@aliax.net"
  spec.summary = "posix_mq library integrated into EventMachine reactor for asynchronous reading"
  spec.homepage = "https://github.com/ibc/em-posixmq"
  spec.description =
    "em-posixmq integrates posix_mq Ruby library into the EventMachine reactor allowing asynchronous reading from a POSIX message queue"
  spec.required_ruby_version = ">= 1.8.7"
  spec.add_dependency "eventmachine"
  spec.add_dependency "posix_mq", ">= 1.0.0"
  spec.files = %w{
    lib/em-posixmq.rb
    lib/em-posixmq/version.rb
    test/test-em-posixmq-client.rb
    test/test-em-posixmq-server.rb
  }
  spec.require_paths = ["lib"]
end
