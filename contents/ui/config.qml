import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ColumnLayout {
    Layout.fillWidth: true
    
    RowLayout {
        spacing: 10
        Layout.fillWidth: true
        
        Label {
            text: "Image path:"
        }
        
        TextField {
            id: pathField
            Layout.fillWidth: true
            text: plasmoid.configuration.imagePath || ""
            onTextChanged: {
                if (text) {
                    plasmoid.configuration.imagePath = text
                }
            }
        }
    }
    
    RowLayout {
        spacing: 10
        Layout.fillWidth: true
        
        Label {
            text: "Corner radius:"
        }
        
        Slider {
            id: radiusSlider
            Layout.fillWidth: true
            from: 0
            to: 50
            value: plasmoid.configuration.cornerRadius || 20
            stepSize: 1
            onValueChanged: {
                plasmoid.configuration.cornerRadius = Math.round(value)
            }
        }
        
        Label {
            text: Math.round(radiusSlider.value) + " px"
            Layout.preferredWidth: 50
        }
    }
    
    Item { Layout.fillHeight: true }
}
