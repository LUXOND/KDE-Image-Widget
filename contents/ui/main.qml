import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: root
    width: 300
    height: 300

    // Make widget completely transparent (no Plasma border/shadow)
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    property string imagePath: plasmoid.configuration.imagePath || ""
    property int cornerRadius: plasmoid.configuration.cornerRadius || 20
    property bool isGif: imagePath.toLowerCase().endsWith(".gif")

    Component.onCompleted: {
        plasmoid.setAction("configure", i18n("Configure"))
    }

    Connections {
        target: plasmoid.configuration
        onImagePathChanged: {
            imagePath = plasmoid.configuration.imagePath || ""
            isGif = imagePath.toLowerCase().endsWith(".gif")
            // Force reload for proper animation
            staticImg.source = ""
            animatedImg.source = ""
            if (isGif) {
                animatedImg.source = imagePath ? "file://" + imagePath : ""
            } else {
                staticImg.source = imagePath ? "file://" + imagePath : ""
            }
        }
        onCornerRadiusChanged: {
            cornerRadius = plasmoid.configuration.cornerRadius || 20
        }
    }

    // Image display with rounded corners - no container needed
    Image {
        id: staticImg
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: imagePath && !isGif ? "file://" + imagePath : ""
        smooth: true
        asynchronous: true
        visible: !isGif

        // Apply rounded corners using opacity mask
        layer.enabled: cornerRadius > 0
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                width: staticImg.width
                height: staticImg.height
                radius: cornerRadius
            }
        }
    }

    // Animated GIF display
    AnimatedImage {
        id: animatedImg
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: imagePath && isGif ? "file://" + imagePath : ""
        smooth: true
        asynchronous: true
        cache: false
        visible: isGif
        playing: visible && source != ""
        paused: false

        // Apply rounded corners using opacity mask
        layer.enabled: cornerRadius > 0
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                width: animatedImg.width
                height: animatedImg.height
                radius: cornerRadius
            }
        }
    }

    // Placeholder text when no image
    Text {
        anchors.centerIn: parent
        text: "Drag & drop image here\nor click to configure"
        visible: !imagePath
        color: "#666"
        font.pixelSize: 14
        horizontalAlignment: Text.AlignHCenter
    }

    // Drag and drop area
    DropArea {
        id: dropArea
        anchors.fill: parent

        onDropped: {
            if (drop.hasUrls) {
                var url = drop.urls[0]
                var path = url.toString()

                // Remove file:// prefix
                if (path.startsWith("file://")) {
                    path = path.substring(7)
                }

                // Decode URI components
                path = decodeURIComponent(path)

                // Check if it's an image or gif
                var lowerPath = path.toLowerCase()
                if (lowerPath.endsWith(".png") || lowerPath.endsWith(".jpg") ||
                    lowerPath.endsWith(".jpeg") || lowerPath.endsWith(".gif") ||
                    lowerPath.endsWith(".bmp") || lowerPath.endsWith(".svg") ||
                    lowerPath.endsWith(".webp")) {

                    plasmoid.configuration.imagePath = path
                    imagePath = path
                    drop.accepted = true
                }
            }
        }

        // Visual feedback for drag over
        Rectangle {
            anchors.fill: parent
            color: "#80ffffff"  // Semi-transparent white overlay
            radius: cornerRadius
            visible: dropArea.containsDrag
            border.width: 2
            border.color: "#0078d4"
        }
    }

    // Click to configure
    MouseArea {
        anchors.fill: parent
        onClicked: plasmoid.action("configure").trigger()
    }
}
