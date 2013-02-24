require 'em-websocket'
require 'json'

port = 9395

EventMachine.run do
  channel = EM::Channel.new 

  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => port, :debug => true) do |ws|

    ws.onopen do

      sid = channel.subscribe {|msg|
        ws.send msg
      }
      puts "Opened connection & subscribing client #{sid}"

      ws.onmessage {|msg|
        puts "Incoming msg from sid #{sid}: #{msg}"
        puts "Pushing to all subscribers: #{msg}"
        channel.push msg
      }

      # close event can come from client or host
      ws.onclose {
        puts "Closing connection & unsubscribing #{sid}"
        channel.unsubscribe(sid) 
      }
    end
  end
  puts "Started websocket at #{port}"
end

