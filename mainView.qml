import QtQuick 2.7
import QtQuick.Controls 2.2

Item {
    Button {
        id: createClass;
        width: parent.width - 20;
        height: 69
        y: 89;
        x: 10;
        text: "Class List";
        background: Rectangle {
            color: "#b53939"
            border.color: "#b53939";
            border.width: 2;
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
        MouseArea {
            anchors.bottomMargin: 0
            anchors.fill: parent;
            onClicked: {
                if(isLoaded == false)
                {
                    mainfunction.inputFile();
                    isLoaded = true;
                }
                mainViews.source = "allClassView.qml";
                topTextbar.buttonValue.visible = true;
                topTextbar.textValue = "Class";
            }
        }
    }

    Button {
        id: createLoadout;
        width: parent.width - 20;
        height: 69
        x: 10;
        y: 168;
        text: "Loadout List";
        background: Rectangle {
            color: "#b53939"
            border.color: "#b53939";
            border.width: 2;
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
        MouseArea {
            anchors.bottomMargin: 0
            anchors.fill: parent;
            onClicked: {
                if(isLoaded == false)
                {
                    mainfunction.inputFile();
                    isLoaded = true;
                }
                mainViews.source = "allLoadoutView.qml";
                topTextbar.buttonValue.visible = true;
                topTextbar.textValue = "Loadout";
            }
        }
        }

    Button {
        id: createCharacter;
        width: parent.width - 20;
        height: 69
        x: 10;
        y: 247;
        text: "Character List";
        background: Rectangle {
            color: "#b53939"
            border.color: "#b53939";
            border.width: 2;
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
        MouseArea {
            anchors.bottomMargin: 0
            anchors.fill: parent;
            onClicked: {
                if(isLoaded == false)
                {
                    mainfunction.inputFile();
                    isLoaded = true;
                }
                mainViews.source = "allCharacterView.qml";
                topTextbar.buttonValue.visible = true;
                topTextbar.textValue = "Character";
            }
        }
        }

    Button {
        id: armyList;
        width: parent.width - 20;
        height: 69
        x: 10;
        y: 326;
        text: "Army List";
        background: Rectangle {
            color: "#b53939"
            border.color: "#b53939";
            border.width: 2;
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
        MouseArea {
            anchors.bottomMargin: 0
            anchors.fill: parent;
            onClicked: {
                if(isLoaded == false)
                {
                    mainfunction.inputFile();
                    isLoaded = true;
                }
                mainViews.source = "allArmyView.qml";
                topTextbar.buttonValue.visible = true;
                topTextbar.textValue = "Choose the armies you want.";
            }
        }
        }

}
