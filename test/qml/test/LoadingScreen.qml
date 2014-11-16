import QtQuick 2.0
Rectangle {
    id: _Rectangle_Loading
    anchors.centerIn: parent
    width: 200; height: 200
    radius: width * 0.5
    color: "#545151"
    visible: true
    smooth: true
    Rectangle {
        id: _Rectangle_Second
        anchors.centerIn: parent
        width: 100; height: 100
        radius: width * 0.5
        color: "#ffffff"
    }
    Rectangle {
        id: _Rectangle_Small
        anchors.top: _Rectangle_Loading.top
        //            anchors.bottom: _Rectangle_Second.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 5; height: 5
        radius: width * 0.5
        color: "#ffffff"
        visible: true
        smooth: true
    }
    SequentialAnimation {
        loops: Animation.Infinite
        running: _Rectangle_Loading.visible
        NumberAnimation {
            id: _NumberAnimation
            target: _Rectangle_Small
            property: "rotation"
            from: 0; to: 360;
            duration: 2400
        }
    }
}

