import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    y: 80;
    id: classPreview;
    property string className: "";
    property var skillLists: [];

    property int numSkills: 0;
    property int level: 0;
    property int numPoints: 0;
    property int numHealth: 0;
    property int numDefence: 0;
    property int numAction: 0;
    property int numStrength: 0;
    property int numMovement: 0;

    function setName(name)
    {
        className = name;
        numPoints = mainfunction.getClassPoints(className);
        level = mainfunction.getClassLevel(className);
        numHealth = mainfunction.getClassHealth(className);
        numDefence = mainfunction.getClassDefence(className);
        numAction = mainfunction.getClassAction(className);
        numStrength = mainfunction.getClassStrength(className);
        numMovement = mainfunction.getClassMovement(className);
        getSkillsList();
    }

    function getSkillsList()
    {
        for(var a = 8; a < mainfunction.getClassListLength(className); a++)
        {
            skillLists[numSkills] = mainfunction.getSkill(className, a);
            numSkills = numSkills + 1;
        }
        skillList.model = skillLists;
    }

    Label {
        x: 10;
        y: 0;
        width: parent.width - 20;
        text: className;
        font.pointSize: 30;
    }

    Label {
        x: 10;
        y: 40;
        width: parent.width - 20;
        text: "Level: " + level;
        font.pointSize: 27;
    }

    Tumbler {
        id: skillList
        x: 10;
        y: 70;
        width: parent.width - 20;
        height: 365;
        font.pointSize: 20;
    }

    Button {
        x: 10
        y: 435
        width: parent.width - 20;
        height: 40
        text: "Skill's Description";
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
            text: "Skill's Information";
            anchors.horizontalCenter: parent.horizontalCenter;
            y: 10;
            color: "#FFFFFF";
        }
        Label {
            text: "";
            anchors.horizontalCenter: parent.horizontalCenter;
            y: 40;
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
        x: 8;
        y: 485;
        width: 565;
        height: 52;
        text: "Total point: " + numPoints + "\n" + "Health: " + numHealth + " Defence: " + numDefence + " Action: " + numAction + "\n" + "Strength: " + numStrength + " Movement: " + numMovement + "cm";
        font.pointSize: 20;
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
                mainViews.source = "Class.qml";
                topTextbar.textValue = "Edit Class";
                mainViews.item.setName(className);
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
