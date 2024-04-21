#!/bin/bash

# Preliminary check for required commands
commands="convert identify parallel ffmpeg"
for cmd in $commands; do
    if ! command -v $cmd &> /dev/null; then
        echo "$cmd could not be found, please install it to continue."
        exit 1
    fi
done

trap 'echo "Script interrupted. Cleaning up..."; rm -rf frames; exit 1' INT

echo "Cleaning up old files..."
rm -f combined.png
rm -rf frames
mkdir -p frames
rm -f panning_video.mp4

echo "Combining images..."
# First determine the maximum width to be used in extent
max_width=$(convert ./products/*.png -resize x1080 -format "%[w]" info: | sort -n | tail -1)

# Resize each image to have a height of 1080px and standardize the width
convert ./products/*.png -resize x1080 -background white -gravity center -extent ${max_width}x1080 +append combined.png

echo "Generating frames..."

frame_width=1920
frame_height=1080
composite_width=$(identify -format "%w" combined.png)
shift_per_frame=10
num_frames=$(( (composite_width - frame_width) / shift_per_frame ))

parallel --bar convert combined.png -crop ${frame_width}x${frame_height}+{1}+0 frames/frame_{#}.png ::: $(seq 0 $shift_per_frame $((num_frames * shift_per_frame)))

cd frames
for file in frame_*.png; do
    number=$(echo $file | sed 's/frame_\(.*\).png/\1/')
    new_name=$(printf "frame_%04d.png" $number)
    mv $file $new_name
done
cd ..

echo "Creating video..."
ffmpeg -framerate 48 -pattern_type glob -i 'frames/*.png' -c:v libx264 -pix_fmt yuv420p panning_video.mp4

echo "Video generation complete! Check out panning_video.mp4"
