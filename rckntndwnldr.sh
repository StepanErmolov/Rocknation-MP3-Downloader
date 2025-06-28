#!/bin/bash



function download() {
	grep -oP 'https?://[^"]+?\.mp3' /tmp/rckntn.html | while
	read -r url; do
		echo "Downloading $url..."
		wget --continue "$url" >/dev/null
	done
}

function download_from_page() {
	curl "$1" -o /tmp/rckntn.html
 	dir=$(sed -n 's|.*<title>\(.*\) listen online слушать онлайн mp3 download скачать rocknation.su</title>.*|\1|p' /tmp/rckntn.html)
	mkdir "$dir"
	cd "$dir"
	download
 	cd ..
}

for arg; do
	download_from_page "$arg"
done

rm -rf /tm/rckntn.html
