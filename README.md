# video-replay

A [Viam](https://viam.com/) camera module that replays a local video file as a virtual camera. It reads frames from a video file at the file's native FPS and serves them as JPEG images through Viam's camera API, looping back to the beginning when the video ends. Useful for testing and development.

## Model: `bill:video-replay:video`

### Requirements

- [OpenCV 4](https://opencv.org/) (with contrib modules) must be installed on the host machine
- Supported architectures: `linux/amd64`, `linux/arm64`

### Configuration

```json
{
  "video_path": "/path/to/your/video.mp4"
}
```

### Attributes

| Name         | Type   | Inclusion | Description                          |
|--------------|--------|-----------|--------------------------------------|
| `video_path` | string | Required  | Absolute path to the video file      |

### Example configuration

```json
{
  "components": [
    {
      "name": "my-replay-cam",
      "api": "rdk:component:camera",
      "model": "bill:video-replay:video",
      "attributes": {
        "video_path": "/home/user/videos/test.mp4"
      }
    }
  ],
  "modules": [
    {
      "type": "registry",
      "name": "bill_video-replay",
      "module_id": "bill:video-replay",
      "version": "latest"
    }
  ]
}
```

## Building from source

```bash
# Install OpenCV (macOS)
brew install opencv

# Install system dependencies (Linux)
make setup

# Build the binary
make build

# Package as a module tarball
make module.tar.gz
```

## Limitations

- Returns JPEG images only
- No point cloud support
- Hardcoded intrinsic parameters (640x480)
