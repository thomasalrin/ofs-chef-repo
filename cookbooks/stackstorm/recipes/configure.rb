echo "Ch@ngeMe" | sudo htpasswd -i /etc/st2/htpasswd st2admin

Enable and configure auth in /etc/st2/st2.conf:

[auth]
# ...
enable = True

sudo st2ctl restart-component st2api


st2 run packs.install packs=st2




