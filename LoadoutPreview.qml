import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    y: 80;
    id: loadoutPreview;
    property string loadoutName: "";
    property var loadoutLists: [];

    property int numPoints: 0;
    property int numLoadouts: 0;

    function setName(name)
    {
        loadoutName = name;
        numPoints = mainfunction.getLoadoutPoints(loadoutName);
        getLoadoutsList();
    }

    function getLoadoutsList()
    {
        for(var a = 2; a < mainfunction.getLoadoutListLength(loadoutName); a++)
        {
            loadoutLists[numLoadouts] = mainfunction.getLoadout(loadoutName, a);
            numLoadouts = numLoadouts + 1;
        }
        loadoutList.model = loadoutLists;
    }

    Label {
        id: nameText;
        x: 10;
        y: 0;
        width: parent.width - 20;
        text: loadoutName;
        font.pointSize: 30;
    }

    Label {
        id: pointLabel;
        x: 8;
        y: 485;
        width: 565
        height: 52
        text: "Total point: " + numPoints;
        font.pointSize: 20;
    }

    Tumbler {
        id: loadoutList
        x: 10;
        y: 46
        width: parent.width - 20;
        height: 382
        font.pointSize: 20;
    }

    Button {
        x: 10
        y: 435
        width: parent.width - 20;
        height: 40
        text: "Item's Description";
        MouseArea {
            anchors.bottomMargin: 0
            anchors.fill: parent;
            onClicked: {
                info.visible = true;
            }
        }
    }

    Rectangle {
        id: info;
        visible: false;
        x: 10;
        y: parent.height / 2 - 190;
        width: parent.width - 20;
        height: 200;
        color: "#4BB441";
        Label {
            text: "Item's Information";
            anchors.horizontalCenter: parent.horizontalCenter;
            y: 10;
            color: "#FFFFFF";
        }
        Label {
            text: "Damage: ";
            anchors.horizontalCenter: parent.horizontalCenter;
            y: 40;
            font.pointSize: 20;
            color: "#FFFFFF";
        }
        Label {
            text: "Range dropoff: ";
            anchors.horizontalCenter: parent.horizontalCenter;
            y: 70;
            font.pointSize: 20;
            color: "#FFFFFF";
        }
        Label {
            text: "Ammo: ";
            anchors.horizontalCenter: parent.horizontalCenter;
            y: 100;
            font.pointSize: 20;
            color: "#FFFFFF";
        }
        Button {
            text: "OK";
            anchors.bottom: parent.bottom;
            anchors.horizontalCenter: parent.horizontalCenter;
            contentItem: Text {
                text: parent.text;
                opacity: 1.0
                font.pointSize: 20;
                color: "#ffffff";
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            MouseArea {
            anchors.fill: parent;
            onClicked: {
                info.visible = false;
            }
            }
            background: Rectangle{
            color: "#4BB441";
            }
        }
    }

    RoundButton {
        x: parent.width - 60;
        y: parent.height - 140;
        width: 50;
        height: 50;
        text: "Edit";
        MouseArea {
            anchors.bottomMargin: 0
            anchors.fill: parent;
            onClicked: {
                mainViews.source = "Loadout.qml";
                topTextbar.textValue = "Edit Loadout";
                mainViews.item.setName(loadoutName);
            }
        }
        contentItem: Text{
            text: parent.text;
            opacity: 1.0
            font.pointSize: 20;
            color: "#ffffff";
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle{
            color: "#4BB441"
            radius: width * 0.5
        }
    }
}
