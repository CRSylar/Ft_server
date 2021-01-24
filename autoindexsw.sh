
#!/bin/bash

if grep -q autoindex on /etc/nginx/sites-avaible/default
then
	sed -i 's/autoindex on/autoindex off/g'
	echo "autoindex off"
else
	sed -i 's/autoindex off/autoindex on/g'
	echo "autoindex on"
fi
