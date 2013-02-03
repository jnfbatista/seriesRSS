#!/bin/env ruby


# main function:
# - gets the config (which is included in a 'require')
# - dowloads the torrent 
def main
  file = '/tmp/shit'

  f = File.open(file, 'w') #{ |file|  }
  loop do 
    f.puts "your text"
    f.flush
    puts "puts puts"
    sleep(5)
    # loads the file to the configuration object

  end
  f.close
end

# deamonize
def daemonize 

end

# prints the usage 
def usage

end

# gets the file and stores it
def get_series

end


# Run da bitch
main
