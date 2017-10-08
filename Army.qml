import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    property var classModel: ["Choose the class"];
    property var loadoutModel: ["Choose the loadout"];
    property var itemModel: [];
    property int numPoints: 0;
    property int numItems: 0;
    height: 626

    function getItems()
    {
        for(var a = 0; a < mainfunction.getClassListLength(); a++)
        {
            classModel[a + 1] = mainfunction.getClassName(a);
        }

        for(var a = 0; a < mainfunction.getLoadoutListLength(); a++)
        {
            loadoutModel[a + 1] = mainfunction.getLoadoutName(a);
        }
    }

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
        id: classList;
        x: 10
        y: 135
        width: parent.width - 20;
        height: 114
        model: classModel;
        onCurrentIndexChanged: {
            if(currentIndex == 0)
            {
                previewClass.enabled = false;
                addClass.enabled = false;
            }else{
                previewClass.enabled = true;
                addClass.enabled = true;
            }
        }
    }

    Button {
        id: addClass
        x: 10
        y: 255
        width: (parent.width / 2) - 10;
        height: 33
        text: "Add Class";
        onClicked: {
        itemModel[numItems] = "Class: " + classModel[classList.currentIndex];
        itemsList.model = itemModel;
        numItems = numItems + 1;
        }
    }

    Button {
        id: previewClass;
        x: (parent.width / 2) + 10;
        y: 255;
        width: (parent.width / 2) - 20;
        height: 33;
        text: "Preview Class";
        onClicked: {
            isArmyPreview = true;
            mainViews.source = "ClassPreview.qml";
            mainViews.item.setName(classModel[classList.currentIndex]);
            topTextbar.textValue = "Class Preview";
        }
    }

    Tumbler {
        id: loadoutList;
        x: 10
        y: 290
        width: parent.width - 20;
        height: 114
        model: loadoutModel;
        onCurrentIndexChanged: {
            if(currentIndex == 0)
            {
                previewLoadout.enabled = false;
                addLoadout.enabled = false;
            }else{
                previewLoadout.enabled = true;
                addLoadout.enabled = true;
            }
        }
    }

    Button {
        id: addLoadout
        x: 10
        y: 410
        width: (parent.width / 2) - 10;
        height: 33
        text: "Add Loadout";
        onClicked: {
        itemModel[numItems] = "Loadout: " + loadoutModel[loadoutList.currentIndex];
        itemsList.model = itemModel;
        numItems = numItems + 1;
        }
    }

    Button {
        id: previewLoadout;
        x: (parent.width / 2) + 10;
        y: 410;
        width: (parent.width / 2) - 20;
        height: 33;
        text: "Preview Loadout";
        onClicked: {
            isArmyPreview = true;
            mainViews.source = "LoadoutPreview.qml";
            mainViews.item.setName(loadoutModel[loadoutList.currentIndex]);
            topTextbar.textValue = "Loadout Preview";
        }
    }

    Tumbler {
        id: itemsList
        x: 10
        y: 455
        width: (parent.width / 2) - 10;
        height: 84
        model: itemModel;
    }

    Button {
        id: previewItem
        x: (parent.width / 2) + 10;
        y: 460
        width: (parent.width / 2) - 10;
        height: 33
        text: "Preview";
    }

    Button {
        id: deleteItem
        x: (parent.width / 2) + 10;
        y: 506
        width: (parent.width / 2) - 10;
        height: 33
        text: "Delete Item";
    }

    Label {
        id: pointLabel;
        x: 8
        y: 565
        width: 565
        height: 52
        text: "Total point: " + numPoints;
        font.pointSize: 20;
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
                mainViews.source = "allArmySelector.qml";
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
