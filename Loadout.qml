import QtQuick 2.7
import QtQuick.Controls 2.2

Item {
    property int numPoints: 0;
    property var itemLists: [];
    property int numItems: 0;
    property string loadoutName: "";
    property var items: {"Body Armor (5 points)" : [5],
                        "Robust Assault Rifle (5 points)" : [5],
                        "Advanced Assault Rifle (10 points)" : [10],
                        "Hunting Rifle (5 points)" : [5],
                        "Designated Marksman Rifle (10 points)" : [10],
                        "Sniper Rifle (15 points)" : [15],
                        "Anti-Material Rifle (15 points)" : [15],
                        "Sub Machine Gun (10 points)" : [10],
                        "Light Machine Gun (15 points)" : [15],
                        "Medium Machine Gun (20 points)" : [20],
                        "Handgun (5 points)" : [5],
                        "Magnum Handgun (10 points)" : [10],
                        "Shotgun (10 points)" : [10],
                        "Assault Shotgun (15 points)" : [15],
                        "Blade (5 points)" : [5],
                        "Scope (5 points)" : [5],
                        "Grenade Launcher (10 points)" : [10],
                        "Rotary Grenade Launcher (20 points)" : [20],
                        "Grenade Belt (5 points)" : [5]};

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
            itemLists[numItems] = mainfunction.getLoadout(loadoutName, a);
            numItems = numItems + 1;
        }
        itemList.model = itemLists;
    }

    TextField {
        id: nameText;
        x: 10;
        y: 89;
        width: parent.width - 20;
        placeholderText: "Enter name";
        inputMethodHints: Qt.ImhNoPredictiveText;
        text: loadoutName
    }

    Tumbler {
        id: firstModel;
        x: 10
        y: 135;
        width: parent.width - 20;
        height: 150;
        font.pointSize: 18;
        model: Object.keys(items);
    }

    Button {
        id: addItem;
        x: 10
        y: 290
        width: parent.width / 2 - 15;
        height: 40
        text: "Add Item";
            onClicked: {
                var duplicate = false;
                /*for(var a = 0; a < itemLists.length; a++)
                {
                    if(firstModel.model[firstModel.currentIndex] == itemLists[a])
                    {
                        duplicate = true;
                        addItem.text = "You already have";
                        iteminfoButton.text = "this item!";
                        alert.start();
                    }
                }*/
                if(duplicate == false)
                {
                    itemLists[numItems] = firstModel.model[firstModel.currentIndex];
                    numItems = numItems + 1;
                    itemList.model = itemLists;
                    numPoints = numPoints + items[firstModel.model[firstModel.currentIndex]][0];
                }
            }
        Timer {
            id: alert;
            interval: 3000; running: false;
            onTriggered: {
            addItem.text = "Add Item";
            iteminfoButton.text = "Item's Description";
            }
        }
    }

    Button {
        x: parent.width / 2 + 10;
        y: 290
        id: iteminfoButton;
        width: parent.width / 2 - 20;
        height: 40
        text: "Item's Description";
        onClicked: {
                info.visible = true;
        }
    }


    Tumbler {
        id: itemList
        x: 10
        y: 345
        width: parent.width - 20;
        height: 171
        font.pointSize: 18
    }

    Button {
        id: deleteSkill;
        x: 10
        y: 525
        width: parent.width - 20;
        height: 40
        text: "Delete Item";
        onClicked: {
                numPoints = numPoints - items[itemLists[itemList.currentIndex]][0];
                itemLists.splice(itemList.currentIndex, 1);
                numItems = numItems - 1;
                itemList.model = itemLists;
        }
    }

    Rectangle {
        id: info;
        visible: false;
        x: 10;
        y: parent.height / 2 - 100;
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
            onClicked: {
                if(nameText.text == "")
                {
                    nonamealert.running = true;
                    nameText.placeholderText = "Please input a name!";
                    return;
                }
                mainfunction.createLoadout(nameText.text, numPoints);
                for(var a = 0; a < itemList.count; a++)
                {
                    mainfunction.setLoadoutValue(itemList.model[a]);
                }
                mainfunction.loadoutfinished();
                mainfunction.outputFile();
                mainViews.source = "allLoadoutView.qml";
                topTextbar.textValue = "Loadout";
                pointLabel.visible = false;
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

