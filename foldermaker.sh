#!/bin/bash
cd $1

for x in *.mp4 *.webm *.avi *.mkv; do
    RES=$(ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=s=x:p=0 "$x")
    VID_CODEC=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$x")
    AUDIO_CODEC=$(ffprobe -v error -select_streams a:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$x")
    CHANNELS=$(ffprobe -i "$x" -show_entries stream=channels -select_streams a:0 -of compact=p=0:nk=1 -v 0)
    mkdir "$x [$RES $VID_CODEC $AUDIO_CODEC $CHANNELS]" && mv "$x" "$x [$RES $VID_CODEC $AUDIO_CODEC $CHANNELS]"
done
