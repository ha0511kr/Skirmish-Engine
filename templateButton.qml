import QtQuick 2.9
import QtQuick.Controls 2.2

Item {

    property int second;

    Component.onCompleted: {
        second = parent.width / 3;
    }

    Button {
        id: addItem;
        text: "+";
        x: 0;
        y: parent.height - 60;
        width: second;
        height: 60;

        contentItem: Text{
            text: parent.text;
            opacity: 1.0
            font.pointSize: 20;
            color: "#FFFFFF";
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        MouseArea {
            anchors.bottomMargin: 0
            anchors.fill: parent;
            onClicked: {
                if(mainViews.source == "qrc:/allClassView.qml")
                {
                    mainViews.source = "Class.qml";
                    topTextbar.textValue = "Create Class";
                }else if(mainViews.source == "qrc:/allLoadoutView.qml")
                {
                    mainViews.source = "Loadout.qml";
                    topTextbar.textValue = "Create Loadout";
                }else if(mainViews.source == "qrc:/allArmySelector.qml")
                {
                    mainViews.source = "Army.qml";
                    topTextbar.textValue = "Create Army";
                    mainViews.item.getItems();
                }
            }
        }

        background: Rectangle {
            color: "#4BB441"
            border.color: "#469b3e";
            border.width: 2;
        }
    }

    Button {
        id: editItem;
        text: "Edit";
        x: second;
        y: parent.height - 60;
        width: second;
        height: 60;
        contentItem: Text{
            text: parent.text;
            opacity: 1.0
            font.pointSize: 20;
            color: "#FFFFFF";
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        MouseArea {
            anchors.bottomMargin: 0
            anchors.fill: parent;
            onClicked: {
                if(mainViews.source == "qrc:/allClassView.qml")
                {
                    topTextbar.textValue = "Select the class";
                    mainViews.item.setMode(1);
                }else if(mainViews.source == "qrc:/allLoadoutView.qml")
                {
                    topTextbar.textValue = "Select the loadout";
                    mainViews.item.setMode(1);
                }else if(mainViews.source == "qrc:/allArmySelector.qml")
                {
                    topTextbar.textValue = "Select the army";
                }
            }
        }
        background: Rectangle {
            color: "#4BB441"
            border.color: "#469b3e";
            border.width: 2;
        }
    }

    Button {
        id: deleteItem;
        text: "-";
        x: second + second;
        y: parent.height - 60;
        width: second
        height: 60;

        contentItem: Text{
            text: parent.text;
            opacity: 1.0
            font.pointSize: 20;
            color: "#FFFFFF";
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        MouseArea {
            anchors.bottomMargin: 0
            anchors.fill: parent;
            onClicked: {
                if(mainViews.source == "qrc:/allClassView.qml")
                {
                    topTextbar.textValue = "Select the class";
                    mainViews.item.setMode(2);
                }else if(mainViews.source == "qrc:/allLoadoutView.qml")
                {
                    topTextbar.textValue = "Select the loadout";
                    mainViews.item.setMode(2);
                }else if(mainViews.source == "qrc:/allArmySelector.qml")
                {
                    topTextbar.textValue = "Select the army";
                }
            }
        }

        background: Rectangle {
            color: "#4BB441"
            border.color: "#469b3e";
            border.width: 2;
        }
    }
}
