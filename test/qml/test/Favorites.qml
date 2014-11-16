import QtQuick 2.0
Component {
    Item {
        Text {
            id: _Text
            visible: _ListView.model.count === 0
//            anchors.leftMargin: 40
//            anchors.rightMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 70
            width: parent.width
            maximumLineCount: 4
            font.pixelSize: 70
            font.family: "Roboto Condensed"
            font.bold: true
            color: "#545151"
            text: "You do not have any favorites yet!"
        }
        ListView {
            id: _ListView
            anchors.fill: parent
            model: root.favoritesModel
            delegate: Rectangle {
                id: _Rectangle_Degelate
                width: ListView.view.width
                height: 480
                color: "#545151"
                Column {
                    id: _Column
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        id: _Text_Title
                        text: model.title
                        font.bold: true
                        maximumLineCount: 4
                        width: parent.width
                        wrapMode: Text.WordWrap
                        color: "#ffffff"
                    }
                    Label { text: model.description }
                    Label { text: model.date }
                    Label { text: model.time }
                }
                MouseArea {
                    anchors.fill: _Column
                    onClicked: {
                        console.log("link clicked = " + model.link)
                        Qt.openUrlExternally(model.link)
                    }
                }
                Rectangle {
                    id: _Rectangle_AccentBottom
                    width: parent.width
                    height: 10
                    color: "#ffffff"
                }
            }
        }
    }
}
