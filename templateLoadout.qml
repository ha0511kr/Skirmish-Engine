import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    property string loadoutName: "";
    property int loadoutPoints: 0;
    property int mode: 0;
    function setHeight(height)
    {
        rect.y = height;
    }

    function setName(name)
    {
        loadoutName = name;
    }

    function setPoints(level)
    {
        loadoutPoints = level;
    }

    function setEdit(modes)
    {
        mode = modes;
    }

    Button {
        id: rect;
        x: 10;
        y: 0;
        width: 355;
        height: 50;
        background: Rectangle {
            color: "#4BB441";
        }
        MouseArea {
            anchors.bottomMargin: 0
            anchors.fill: parent;
            onClicked: {
                switch(mode)
                {
                case 0:
                    mainViews.source = "LoadoutPreview.qml";
                    topTextbar.textValue = "Preview";
                    mainViews.item.setName(loadoutName);
                    break;
                case 1:
                    mainViews.source = "Loadout.qml";
                    topTextbar.textValue = "Edit Loadout";
                    mainViews.item.setName(loadoutName);
                    break;
                case 2:
                    mainfunction.deleteLoadout(loadoutName);
                    mainfunction.outputFile();
                    topTextbar.textValue = "Loadout";
                    mainViews.source = "mainView.qml";
                    mainViews.source = "allLoadoutView.qml";
                    break;
                }
            }
        }
        Label {
            y: 5;
            text: "Name: " + loadoutName;
            anchors.horizontalCenter: parent.horizontalCenter;
            font.pointSize: 17;
            color: "#FFFFFF";
        }
        Label {
            y: 25;
            text: "Points: " + loadoutPoints;
            anchors.horizontalCenter: parent.horizontalCenter;
            font.pointSize: 17;
            color: "#FFFFFF";
        }
    }
}
