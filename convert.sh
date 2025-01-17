# Change input and output details

output_path="big-buck-bunnya" # Output Path (Same will be pushed in main also)
input_url="https://serve.goincop2.workers.dev/0:/rayaandthelastdragon.mkv" # Input direct file url
input_extension="mkv" # Extension of file url



# Change ffmpeg configurations according to yur need (If you don't know, don't touch)

wget --quiet -O video.$input_extension $input_url
mkdir $output_path

ffmpeg -hide_banner -y -i video.$input_extension \
  -vf scale=w=1280:h=720:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 2800k -maxrate 2996k -bufsize 4200k -b:a 128k -hls_segment_filename $output_path/720p_%03d.ts $output_path/720p.m3u8 \

rm video.$input_extension
cd $output_path

echo '#EXTM3U
#EXT-X-VERSION:3
#EXT-X-STREAM-INF:BANDWIDTH=2800000,RESOLUTION=1280x720
720p.m3u8' > master.m3u8
