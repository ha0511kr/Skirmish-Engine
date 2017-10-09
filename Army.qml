import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    property var characterModel: ["Choose the character"];
    property var armyModel: [];

    TextField {
        id: nameText;
        x: 10;
        y: 89;
        width: parent.width - 20;
        placeholderText: "Enter name";
        inputMethodHints: Qt.ImhNoPredictiveText;
        text: "";
    }

    Tumbler {
        id: characterList
        x: 10
        y: 135
        width: parent.width - 20
        height: 103
        model: characterModel;
    }

    Button {
        id: addCharacter
        x: 10
        y: 244;
        width: parent.width - 20;
        text: "Add Character";
    }

    Tumbler {
        id: armyList
        x: 10
        y: 290
        width: parent.width - 20
        height: 103
        model: armyModel;
    }

    RoundButton {
        id: creator;
        width: 50;
        height: 50
        x: parent.width - 60;
        y: parent.height - 60;
        text: "✓";
        MouseArea {
            anchors.bottomMargin: 0
            anchors.fill: parent;
            onClicked: {
                if(nameText.text == "")
                {
                    nonamealert.running = true;
                    nameText.placeholderText = "Please input a name!";
                    return;
                }
                mainfunction.outputFile();
                mainViews.source = "allArmyView.qml";
                topTextbar.textValue = "Choose the armies you want.";
                pointLabel.visible = false;
            }
        }

        Timer {
            id: nonamealert;
            interval: 3000; running: false;
            onTriggered: {
            nameText.placeholderText = "Enter name";
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
