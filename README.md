# Panning Video Generator Script

This script generates a smooth panning video across a series of product images, ideal for showcasing product lineups or creating engaging content for marketing.

[ReadmeExample.webm](https://github.com/StevenPartridge/pan-over-images/assets/22158507/72a88fdc-bb7b-43a3-b56f-608d4a63c06d)

## Requirements

Ensure that `ImageMagick`, `GNU Parallel`, and `FFmpeg` are installed on your system. These tools are necessary for image manipulation, parallel processing (wowwee so fast!), and video generation.

## Usage

1. **Prepare Images**:
   - Place your product images into the `./products` directory.
   - Ensure that images are on a simple white background to maintain consistency in the video.
   - Images are in the .png format (use ImageMagic to convert)

2. **Run the Script**:
   - Execute the script by running `./combiner.sh` from the terminal.
   - The script will handle all operations automatically, cleaning up old data, generating new frames, and compiling the final video.

3. **Output**:
   - The final video will be saved as `panning_video.mp4` in the root directory.
   - Intermediate frames will be stored in the `./frames` directory.

## Notes

- The script includes a check to ensure all necessary commands are available before proceeding.
- Interrupting the script (e.g., via Ctrl+C) triggers cleanup to prevent partial data retention.

