import QtQuick 2.9

Item {
    property var classList: [];
    property int intClassList: 0;
    property int windowHeight: 0;

    Loader {
    source: "templateButton.qml"
    anchors.fill: parent;
    visible: true;
    z: 1;
    }

    function setMode(mode)
    {
        for(var a = 0; a < mainfunction.getClassListLength(); a++)
        {
            classList[a].setEdit(mode);
        }
    }

    Flickable {
        contentWidth: parent.width;
        contentHeight: windowHeight;
        anchors.fill: parent;
    Item {
        id: classList;
        y: 90;
        Component.onCompleted: {
            windowHeight = 0;
            for(var a = 0; a < mainfunction.getClassListLength(); a++)
            {
                var comp = Qt.createComponent("templateClass.qml");
                var object = comp.createObject(classList);
                object.setHeight(a * 80);
                object.setName(mainfunction.getClassName(a));
                object.setLevel(mainfunction.getClassLevel(a));
                object.setPoints(mainfunction.getClassPoints(a));
                windowHeight = (a * 80) + 230;
                classList[a] = object;
            }
        }
    }

    }
}
