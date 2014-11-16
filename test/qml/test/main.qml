import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Item {
    id: root
    width: 1080
    height: 1705
    signal concertModelReady;
    property alias concertModel: _ListModel_Concert
    property alias favoritesModel : _ListModel_Favorites
    ListModel { id: _ListModel_Concert }
    ListModel { id: _ListModel_Favorites }
    XmlListModel {
        id: _XmlListModel
        source: "http://acousti.co/feeds/metro_area/Irvine"//"artist.xml"
        query: "/rss/channel/item"
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "link"; query: "link/string()" }
        XmlRole { name: "description"; query: "description/string()" }
        XmlRole { name: "pubDate"; query: "pubDate/string()" }
        onStatusChanged: {
            if(status == XmlListModel.Ready)
            {
                if(count<=0) return;
                for(var i=0; i<count; i++)
                {
                    var a = get(i)
                    console.log("title = " + a.title)
                    console.log("link = " + a.link)
                    console.log("description = " + a.description)
                    console.log("pubDate = " + a.pubDate)
                    console.log("pubDate = " + a.pubDate.slice(0,16))
                    var b = a.pubDate.slice(16)
                    var hourEnd = b.indexOf(":");
                    var H = +b.substr(0, hourEnd);
                    var h = H % 12 || 12;
                    var ampm = H < 12 ? " AM" : " PM";
                    b = h + b.substr(hourEnd, 3) + ampm;
                    console.log("b = " + b)
                    _ListModel_Concert.append({"id": i, "title" : a.title, "link": a.link, "description": a.description, "date": a.pubDate.slice(0, 16), "time" : b })
                }
                root.concertModelReady()
            }
        }
    }
    onConcertModelReady: {
        console.log(root, "onConcertModelReady")
        _Loader.sourceComponent  = _ConcertListView
    }
    Image {
        id: _Image_Header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 147
        source: "img/header-bg.png"
        z: 1
        Image {
            id: _Image_Back
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            source: "img/arrow-left.png"
            visible: _Loader_Favorites.sourceComponent == _Favorites
             MouseArea {
                 anchors.fill: parent
                 onClicked: {
                     _Loader_Favorites.unload()
                 }
             }
        }
        Text {
            anchors.centerIn: parent
            font.pixelSize: 65
            font.family: "Roboto Condensed"
            font.bold: true
            maximumLineCount: 2
            color: "#ffffff"
            text: qsTr("TixTok")
        }
        Image {
            id: _Image_Favorites
            anchors.right: parent.right
            anchors.rightMargin: 30
            anchors.verticalCenter: parent.verticalCenter
            source: "img/notes.png"
            visible: _Loader.sourceComponent == _ConcertListView
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Favorites clicked")
                    _Loader_Favorites.load()
                }
            }
        }
    }
    Loader {
        id: _Loader
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: _Image_Header.bottom
        anchors.topMargin: 30
        anchors.bottom: parent.bottom
        sourceComponent : _LoadingScreen
        LoadingScreen { id : _LoadingScreen }
        ConcertListView { id : _ConcertListView }
    }
    Loader {
        id: _Loader_Favorites
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: _Image_Header.bottom
        anchors.topMargin: 30
        anchors.bottom: parent.bottom
        Favorites { id : _Favorites }
        function load()
        {
            _Loader.visible = false
            _Loader_Favorites.sourceComponent = _Favorites
        }
        function unload()
        {
            _Loader_Favorites.sourceComponent = undefined
            _Loader.visible = true
        }
    }
}

