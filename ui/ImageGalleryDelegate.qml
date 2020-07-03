import QtQuick.Layouts 1.4
import QtQuick 2.9
import QtQuick.Controls 2.12 as Controls
import org.kde.kirigami 2.10 as Kirigami
import QtGraphicalEffects 1.0
import Mycroft 1.0 as Mycroft

Controls.ItemDelegate {
    id: delegate
    
    readonly property GridView gridView: GridView.view
    implicitWidth: gridView.width > 600 ? gridView.cellWidth - Kirigami.Units.gridUnit : gridView.cellWidth
    implicitHeight: gridView.cellHeight - Kirigami.Units.gridUnit
        
    background: Rectangle {
        id: background
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.9)
        radius: 10
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 2
            verticalOffset: 1
        }
    }
    
    contentItem: Rectangle {
        id: frame
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.9)
        radius: 10
        layer.enabled: true
        layer.effect: OpacityMask {
            cached: true
            maskSource: Rectangle {
                x: frame.x;
                y: frame.y
                width: frame.width
                height: frame.height
                radius: frame.radius
            }
        }
        
        Image {
            id: img
            source: model.webformatURL
            opacity: 1
            fillMode: Image.PreserveAspectCrop
            anchors {
                fill: parent
            }
            
            RowLayout{
                anchors.bottom: parent.bottom
                anchors.bottomMargin: Kirigami.Units.largeSpacing
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Kirigami.Units.largeSpacing
                anchors.rightMargin: Kirigami.Units.largeSpacing
                height: parent.height * 0.15
                
                Rectangle {
                    radius: 200
                    color: Qt.rgba(0, 0, 0, 0.5)
                    Layout.alignment: Qt.AlignLeft
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: userImage.width + userName.contentWidth + Kirigami.Units.largeSpacing * 5
                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        horizontalOffset: 2
                        verticalOffset: 1
                    }
                    
                    Image {
                        id: userImage
                        anchors.left: parent.left
                        anchors.leftMargin: Kirigami.Units.largeSpacing * 2
                        anchors.top: parent.top
                        anchors.topMargin: Kirigami.Units.smallSpacing
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: Kirigami.Units.smallSpacing
                        width: height
                        source: model.userImageURL
                    }
                    
                    Controls.Label {
                        id: userName
                        anchors.left: userImage.right
                        anchors.leftMargin: Kirigami.Units.largeSpacing
                        color: "White"
                        text: model.user
                        anchors.verticalCenter: parent.verticalCenter
                    }                    
                }
            }
        }
    }
    
    onClicked: {
        var delegateData = {'id': model.id, 'pageURL': model.pageURL, 'type': model.type, 'tags': model.tags, 'previewURL': model.previewURL, 'previewWidth': model.previewWidth, 'previewHeight': model.previewHeight, 'webformatURL': model.webformatURL, 'webformatWidth': model.webformatWidth, 'webformatHeight': model.webformatHeight, 'largeImageURL': model.largeImageURL, 'imageWidth': model.imageWidth, 'imageHeight': model.imageHeight, 'imageSize': model.imageSize, 'views': model.views, 'downloads': model.downloads, 'favorites': model.favorites, 'likes': model.likes, 'comments': model.comments, 'user_id': model.user_id, 'user': model.user, 'userImageURL': model.userImageURL}
        triggerGuiEvent("pixabay.show.image", delegateData)
    }
}
