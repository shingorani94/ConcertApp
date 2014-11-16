import QtQuick 2.0
Component {
    ListView {
        id: _ListView
        anchors.fill: parent
        model: root.concertModel
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
            Image {
                id: _Image
                property bool isFavorite: false
                anchors.right: parent.right
                anchors.rightMargin: 40
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 40
                source: "img/notes-outline.png"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(_Image.isFavorite)
                        {
                            _Image.source = "img/notes-outline.png"
                            for(var i = 0; i<root.favoritesModel.count; i++)
                            {
                                var o = root.favoritesModel.get(i)
                                if(o.id === model.id)
                                {
                                    root.favoritesModel.remove(i)
                                }
                            }
                        } else {
                            _Image.source = "img/notes.png"
                            root.favoritesModel.append(model)
                        }
                        _Image.isFavorite = !_Image.isFavorite
                        console.log(root.favoritesModel.get(0).title)
                    }
                }
            }
        }
    }
}
