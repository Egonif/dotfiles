# Download audio from YouTube
ytbaudio(){
	yt-dlp -o "%(title)s.%(ext)s" -x --audio-format "${2}" "${1}"
}

# Download video from YouTube
ytbvideo(){
	yt-dlp -S "+codec:h264" -o "%(title)s.%(ext)s" "${1}"
}
