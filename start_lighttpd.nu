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
server.document-root = \"(pwd)\" 
mimetype.assign = \( 
\".html\" => \"text/html;charset=utf-8\", 
\".ico\" => \"image/x-icon\",
\".md\" => \"text/plain;charset=utf-8\",
\".jpg\" => \"image/jpeg\",
\".png\" => \"image/png\",
\) 
"
| save -a $temp_conf
print ( open $temp_conf)
# start lighttpd 
^lighttpd -D -f $temp_conf

# mimetype.assign   = ( ".png"  => "image/png",
#                       ".jpg"  => "image/jpeg",
#                       ".jpeg" => "image/jpeg",
#                       ".html" => "text/html",
#                       ".txt"  => "text/plain;charset=utf-8" )