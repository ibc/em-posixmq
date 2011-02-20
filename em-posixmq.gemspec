Gem::Specification.new do |spec|
  spec.name = "em-posixmq"
  spec.version = "0.1.0"
  spec.date = Time.now
  spec.authors = ["Iñaki Baz Castillo"]
  spec.email = "ibc@aliax.net"
  spec.summary = "posix_mq library integrated into EventMachine reactor for asynchronous reading"
  spec.homepage = "https://github.com/ibc/em-posixmq"
  spec.description =
    "em-posixmq integrates posix_mq Ruby library into the EventMachine reactor allowing asynchronous reading from a Posix message queue"
  spec.required_ruby_version = ">= 1.8.7"
  spec.add_dependency "eventmachine"
  spec.add_dependency "posix_mq"
  spec.files = %w{
    lib/em-posixmq.rb
  }
  spec.require_paths = ["lib"]
end
