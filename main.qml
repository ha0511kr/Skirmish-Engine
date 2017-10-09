import QtQuick 2.9
import QtQuick.Controls 2.2
//import QtQuick.Window 2.0

ApplicationWindow { //This is the Main qml file. This is the main viewer. This contains the top bar that states the current page.
    visible: true;
    width: 375;
    height: 640;
    property bool isLoaded: false;
    property bool isCharacterPreview: false;

    Rectangle {
        id: background;
        x: 0;
        y: 0;
        z: -1;
        width: parent.width;
        height: parent.height;
        color: "#dddddd";
    }

    Rectangle {
        id: topTextbar;
        property alias textValue: label.text;
        property alias buttonValue: button;
        width: parent.width - 20;
        height: 69
        x: 10;
        y: 10;
        z: 1;
        color: "#4BB441";
        Label {
        id: label;
        text: "Main Menu";
        anchors.centerIn: parent
        color: "#FFFFFF";
        font.pointSize: 20;
        }
        Button {
        id: button;
        visible: false;
        z: 1;
        text: "<";
        width: 45;
        height: parent.height;
        background: Rectangle {
        color: "#4BB441";
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
                if(mainViews.source == "qrc:/Class.qml")
                {
                    mainViews.source = "allClassView.qml";
                    topTextbar.textValue = "Class";
                }else if(mainViews.source == "qrc:/Loadout.qml")
                {
                    mainViews.source = "allLoadoutView.qml";
                    topTextbar.textValue = "Loadout";
                }else if(mainViews.source == "qrc:/Character.qml")
                {
                    mainViews.source = "allCharacterView.qml";
                    topTextbar.textValue = "Character";
                }else if(mainViews.source == "qrc:/Army.qml")
                {
                    mainViews.source = "allArmyView.qml"
                    topTextbar.textValue = "Choose the armies you want."
                }else if(mainViews.source == "qrc:/Army.qml")
                {
                    mainViews.source = "allArmyView.qml";
                    topTextbar.textValue = "Choose the armies you want.";
                }else if(mainViews.source == "qrc:/ClassPreview.qml"){
                    if(isCharacterPreview == true)
                    {
                        mainViews.source = "Character.qml";
                        mainViews.item.getItems();
                        topTextbar.textValue = "Create Army";
                        isCharacterPreview = false;
                    }else{
                    mainViews.source = "allClassView.qml";
                    topTextbar.textValue = "Class";
                    }
                }else if(mainViews.source == "qrc:/LoadoutPreview.qml"){
                    if(isCharacterPreview == true)
                    {
                        mainViews.source = "Character.qml";
                        mainViews.item.getItems();
                        topTextbar.textValue = "Create Army";
                        isCharacterPreview = false;
                    }else{
                    mainViews.source = "allLoadoutView.qml";
                    topTextbar.textValue = "Loadout";
                    }
                }else{
                mainViews.source = "mainView.qml";
                topTextbar.textValue = "Main Menu";
                parent.visible = false;
                }
            }
        }
        }
    }

    Loader {
    id: mainViews;
    source: "mainView.qml"
    anchors.fill: parent;
    visible: true;
    }

}
