default[:irccat][:create_user] = true ## if try, "user" resource used to create irccat user

default[:irccat][:git_url] = "git://github.com/RJ/irccat.git"
default[:irccat][:nick] = "irccat"
default[:irccat][:nickserv_password] = ""
default[:irccat][:ircd_host] = "127.0.0.1"
default[:irccat][:ircd_port] = "6667"
default[:irccat][:ircd_password] = ""
default[:irccat][:cat_port] = "12345"
default[:irccat][:cat_host] = "127.0.0.1"
default[:irccat][:script_path] = "/etc/irccat/handler.sh"
default[:irccat][:channels] = [ { :name => "#test", :key => "" } ]
default[:irccat][:user] = "irccat"
