import QtQuick 2.9

Item {

    property var loadoutList: [];
    Loader {
    source: "templateButton.qml"
    anchors.fill: parent;
    visible: true;
    }

    function setMode(mode)
    {
        for(var a = 0; a < mainfunction.getLoadoutListLength(); a++)
        {
            loadoutList[a].setEdit(mode);
        }
    }

    Item {
        id: loadoutList;
        y: 90;
        Component.onCompleted: {
            for(var a = 0; a < mainfunction.getLoadoutListLength(); a++)
            {
                var comp = Qt.createComponent("templateLoadout.qml");
                var object = comp.createObject(loadoutList);
                object.setName(mainfunction.getLoadoutName(a));
                object.setPoints(mainfunction.getLoadoutPoints(a));
                object.setHeight(a * 60);
                loadoutList[a] = object;
            }
        }
    }
}
