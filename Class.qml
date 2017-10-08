import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    z: 0
    property var skillLists: [];
    property var skills: [];
    property int currentModel: 0;
    property string className: "";

    /*
    1. Have every skills in just one single tumbler.
    2. Have every skills in just one single tumbler, you cannot see the skills you don't have the prerequisite.
    3. Just leave it, figure out a way...
    */

    property var defaultModel: {"Firearms Basic" : ["Skirmishing", "Marksmanship"],
                                "Constitution 1" : ["Constitution 2"],
                                "Physique 1" : ["Physique 2", "Throwing Attack"],
                                "Agility 1" : ["Agility 2"],
                                "Leadership 1" : ["Inspire", "Leadership 2"],
                                "Martial Arts" : ["Blade Specialty", "Assault", "Throwing Attack", "Sneak", "Close Quarters Shooting"],
                                "Running 1" : ["Running 2"]};

    property var secondModel: {"Skirmishing" : ["Rifle Specialty", "Quick Draw Shooting", "Automatic Specialty"],
                              "Marksmanship" : ["Rifle Specialty", "Sharpshooting", "Under Fire Aiming", "Quick Aim"],
                              "Constitution 2" : ["Constitution 3"],
                              "Physique 2" : ["Physique 3", "Hard Shot Assault"],
                              "Agility 2" : ["Agility 3", "Dodger", "Gunslinger", "Snapshot Rifle", "Sneak"],
                              "Running 2" : ["Running 3", "Assault"],
                              "Leadership 2" : ["Chain of Command 1", "Leadership 3"],
                              "Blade Specialty" : ["Blade Specialty"],
                              "Sneak" : ["Distraction"]};

    property var thirdModel: {"Leadership 3" : ["Chain of Command 2"],
                              "Chain of Command 1" : ["Chain of Command 2"],
                              "Marksmanship" : ["Rifle Specialty"],
                              "Quick Draw Shooting" : ["Dual Wield Shooting"],
                              "Sneak" : ["Distraction"],
                              "Gunslinger" : ["Close Quarters Shooting"],
                              "Under Fire Aiming" : ["Hard Shot Assault"],
                              "Assault" : ["Hard Shot Assault"]};

    property var specialSkills: {"Consitution 1" : [1, 0, 0, 0, 0]}; //Health, Defence, Action, Strength, Movement

    property int numSkills: 0;
    property int level: 0;
    property int numPoints;
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
    //Flickable {
        //contentWidth: root.width;
        //contentHeight: 640;
        //anchors.fill: parent;
    TextField {
        id: nameText;
        x: 10;
        y: 89;
        width: parent.width - 20;
        placeholderText: "Enter name";
        inputMethodHints: Qt.ImhNoPredictiveText;
        text: className;
    }

    Label {
        x: 10;
        y: 150;
        text: "Level: ";
    }

    SpinBox {
        id: levelSpin;
        x: 60
        y: 138
        width: parent.width - 70;
        height: 40
        value: level;
        from: 0;
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 20
                    border.color: "#b53939";
                    radius: 2
                }
        onValueChanged: {
            numPoints = numPoints - (level * 25);
            numPoints = numPoints + (this.value * 25);
            numHealth = Math.floor(this.value / 2) + 1;
            numDefence = this.value;
            numAction = Math.ceil(this.value / 2) + 1;
            numStrength = this.value;
            numMovement = (this.value * 5) + 5;
            level = this.value;
        }
    }

    function checkforNull()
    {
        var ifNull = false;
        switch(currentModel)
        {
        case 0:
            skills[0] = firstModel.model[firstModel.currentIndex];
            break;
        case 1:
            if(secondModel[firstModel.model[firstModel.currentIndex]] == null)
            {
                next.enabled = false;
                ifNull = true;
            }
            skills[1] = firstModel.model[firstModel.currentIndex];
            break;
        case 2:
            if(thirdModel[firstModel.model[firstModel.currentIndex]] == null)
            {
                next.enabled = false;
                ifNull = true;
            }
            skills[2] = firstModel.model[firstModel.currentIndex];
            break;
        case 3:
            skills[3] = firstModel.model[firstModel.currentIndex]; //Fix This please!!
            next.enabled = false;
            ifNull = true;
            break;
        }
        if(ifNull == false)
        {
            next.enabled = true;
        }
    }

    Tumbler {
        id: firstModel;
        x: 10
        y: 186
        width: parent.width - 20;
        height: 139
        model: Object.keys(defaultModel);
        onCurrentIndexChanged: {
            checkforNull();
        }
        onModelChanged: {
            checkforNull();
        }
        font.pointSize: 18;
    }

    Button {
        id: back;
        x: 10;
        y: 330
        width: (parent.width / 3) - 20;
        height: 40;
        enabled: false;
        text: "Back";
        background: Rectangle {
            color: "#b53939";
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
        onClicked: {
            switch(currentModel)
            {
            case 1:
                firstModel.model = Object.keys(defaultModel);
                skills[1] = "None";
                back.enabled = false;
                next.enabled = true;
                currentModel = currentModel - 1;
                break;
            case 2:
                firstModel.model = defaultModel[skills[0]];
                skills[2] = "None";
                next.enabled = true;
                currentModel = currentModel - 1;
                break;
            case 3:
                firstModel.model = secondModel[skills[1]];
                skills[3] = "None";
                next.enabled = true;
                currentModel = currentModel - 1;
                break;
            }
        }
    }

    Button {
        id: addSkill;
        x: (parent.width / 3);
        y: 330
        width: (parent.width / 3);
        height: 40
        text: "Add Skill";
        background: Rectangle {
            color: "#b53939";
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
            onClicked: {
                var duplicate = false;
                for(var a = 0; a < numSkills; a++)
                {
                    for(var b = 0; b < 4; b++)
                    {
                        if(skills[b] == skillLists[a])
                        {
                            skills[b] = "None";
                        }
                    }
                }
                if(duplicate == false)
                {
                    for(var a = 0; a < 4; a++)
                    {
                        if(skills[a] == "None" || skills[a] == null)
                        {

                        }else{
                        skillLists[numSkills] = skills[a];
                        numSkills = numSkills + 1;
                        numPoints = numPoints + 5;
                        }
                    }
                skillList.model = skillLists;
                }
        }
        Timer {
            id: alert;
            interval: 3000; running: false;
            onTriggered: {
            addSkill.text = "Add Skill";
            }
        }
    }

    Button {
        id: next;
        x: (parent.width / 3) * 2 + 10;
        y: 330
        width: (parent.width / 3) - 20;
        height: 40;
        text: "Next";
        background: Rectangle {
            color: "#b53939";
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
        onClicked: {
            switch(currentModel)
            {
            case 0:
                skills[0] = firstModel.model[firstModel.currentIndex];
                currentModel = currentModel + 1;
                firstModel.model = defaultModel[firstModel.model[firstModel.currentIndex]];
                back.enabled = true;
                break;
            case 1:
                skills[1] = firstModel.model[firstModel.currentIndex];
                currentModel = currentModel + 1;
                firstModel.model = secondModel[firstModel.model[firstModel.currentIndex]];
                break;
            case 2:
                skills[2] = firstModel.model[firstModel.currentIndex];
                currentModel = currentModel + 1;
                firstModel.model = thirdModel[firstModel.model[firstModel.currentIndex]];
                break;
            }
        }
    }

    Tumbler {
        id: skillList
        x: 10
        y: 379
        width: parent.width - 20;
        height: 139
        font.pointSize: 18
    }

    Button {
        id: deleteSkill;
        x: 10
        y: 525
        width: parent.width - 20;
        height: 40
        text: "Delete Skill";
        background: Rectangle {
            color: "#b53939";
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
            var current = skillList.currentIndex;
            skillLists.splice(current, 1);
            numPoints = numPoints - 5;
            numSkills = numSkills - 1;
            skillList.model = skillLists;
            }
        }
    }

    Label {
        id: pointLabel;
        x: 8
        y: 565
        width: 565
        height: 52
        text: "Total point: " + numPoints + "\n" + "Health: " + numHealth + " Defence: " + numDefence + " Action: " + numAction + "\n" + "Strength: " + numStrength + " Movement: " + numMovement + "cm";
        font.pointSize: 20;
    }

    RoundButton {
        id: creator;
        width: 50;
        height: 50
        y: parent.height - 60;
        x: parent.width - 60;
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
                mainfunction.createClass(nameText.text, levelSpin.value, numPoints, numHealth, numDefence, numAction, numStrength, numMovement);
                for(var a = 0; a < skillList.count; a++)
                {
                    mainfunction.setClassValue(skillList.model[a]);
                }
                mainfunction.classfinished();
                mainfunction.outputFile();
                mainViews.source = "allClassView.qml";
                topTextbar.textValue = "Class";
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

