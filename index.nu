# index.nu
#
# serves static content using lighttpd
# which is only 1 command plus a config file
# 
# we are using nu to create a temp conf file
# with the current folder as document root
# 

# create temp file to hold config
let temp_conf = ( ^mktemp )

# set current folder as document root along with port and default page
# save config to temp file
$"server.port = 8080
index-file.names = \( "index.html" \)
server.document-root = "(pwd)" " | save -a $temp_conf

# start lighttpd 
^lighttpd -D -f $temp_conf
