import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    property string className: "";
    property int classLevel: 0;
    property int classPoints: 0;
    property int mode: 0;
    function setHeight(height)
    {
        rect.y = height;
    }

    function setName(name)
    {
        className = name;
    }

    function setLevel(level)
    {
        classLevel = level;
    }

    function setPoints(points)
    {
        classPoints = points;
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
        height: 70;
        background: Rectangle {
            color: "#b53939";
        }
        MouseArea {
            anchors.bottomMargin: 0
            anchors.fill: parent;
            onClicked: {
                switch(mode)
                {
                case 0:
                    mainViews.source = "ClassPreview.qml";
                    topTextbar.textValue = "Preview";
                    mainViews.item.setName(className);
                    break;
                case 1:
                    mainViews.source = "Class.qml";
                    topTextbar.textValue = "Edit Class";
                    mainViews.item.setName(className);
                    break;
                case 2:
                    mainfunction.deleteClass(className);
                    mainfunction.outputFile();
                    topTextbar.textValue = "Class";
                    mainViews.source = "mainView.qml";
                    mainViews.source = "allClassView.qml";
                    break;
                }
            }
        }
        Label {
            y: 5;
            text: "Name: " + className;
            anchors.horizontalCenter: parent.horizontalCenter;
            font.pointSize: 17;
            color: "#FFFFFF";
        }
        Label {
            y: 25;
            text: "Level: " + classLevel;
            anchors.horizontalCenter: parent.horizontalCenter;
            font.pointSize: 17;
            color: "#FFFFFF";
        }
        Label {
            y: 45;
            text: "Points: " + classPoints;
            anchors.horizontalCenter: parent.horizontalCenter;
            font.pointSize: 17;
            color: "#FFFFFF";
        }
    }
}
