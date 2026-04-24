# KDE Image Widget

A KDE Plasma widget that displays images or GIFs on your desktop with rounded corners and no borders.

## Features

- 📷 Display static images (PNG, JPG, BMP, SVG, WebP)
- 🎬 Animated GIF support
- 🔘 Customizable corner radius
- 🎨 Clean UI with no borders
- ⚙️ Easy configuration via widget settings

## Installation

### From Source

1. Clone or extract this project:
```bash
cd KDE-Image-Widget
```

2. Build and install:
```bash
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$(kf6-config --prefix) ..
make
make install
```

3. Restart Plasma or restart your session:
```bash
kquitapp6 plasmashell && plasmashell &
```

4. Right-click on your desktop and select "Add Widget" → search for "Image Widget"

### Manual Installation

1. Create the widget directory:
```bash
mkdir -p ~/.local/share/plasma/plasmoids/org.kde.image-widget
```

2. Copy the contents:
```bash
cp -r . ~/.local/share/plasma/plasmoids/org.kde.image-widget/
```

3. Restart Plasma:
```bash
kquitapp6 plasmashell && plasmashell &
```

## Usage

1. Add the widget to your desktop
2. Click on the widget or right-click → "Configure Widget"
3. Click "Browse..." to select an image or GIF
4. Adjust the corner radius (0-50 pixels)
5. The widget will display your image with the configured rounded corners

## Supported Formats

- **Static Images**: PNG, JPG, JPEG, BMP, SVG, WebP
- **Animated**: GIF

## Configuration

The widget stores settings in:
`~/.config/plasmashellrc` under the widget's configuration group

### Available Settings

- `imagePath`: Full path to the image or GIF file
- `cornerRadius`: Corner radius in pixels (0-50, default: 20)

## Customization

You can edit `contents/ui/main.qml` to customize:

- Default widget size (modify `width` and `height`)
- Image fill mode (PreserveAspectCrop, PreserveAspectFit, etc.)
- Default corner radius
- Colors and styling

## Requirements

- KDE Frameworks 6+
- Qt 6+
- KDE Plasma 6+

## License

GPL v3

## Notes

- Click on the widget to open the configuration dialog if no image is selected
- GIF animations play automatically
- The widget preserves aspect ratio and crops images to fit the widget size
- No borders are displayed by default for a clean look
