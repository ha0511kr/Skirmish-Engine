#include "mainfunction.h"

/*
Description of each variable:
[] - class, loadout, army
[]ClassList - Temporaray list that stores class data (Only used when adding class, data inside the list is deleted after the class data is stored into classInfo)
[]Class - Temporary variable that stores class name (Only used when adding class, the name is deleted after the class data is stored into classInfo)
[]NameList - A list that stores every class name (This is used for tracking how many classes there are and used to checking duplicates)
[]Info - A dictionary that stores all the classes data. (This is used for getting classes data. To get a class data, you need to input the class name)
*/

mainfunction::mainfunction(QObject *parent)
    : QObject(parent)
{

}

mainfunction::~mainfunction()
{

}

//CLASS

void mainfunction::createClass(QString className, int level, int point, int health, int defence, int action, int strength, int movement) //Function that creates class, Input: Class name, class level, class point, etc...
{
    currentClassList = null; //Set the currentclasslist to blank list
    currentClass = className; //Set the currentClass (takes classname) as the className
    if(!(classNameList.contains(currentClass))) //Checks if the class already exists
    {
        classNameList.append(currentClass); //If not, add the class name to the classNameList
    }else{
        classInfo.erase(currentClass);
    }
    currentClassList.append(currentClass);
    currentClassList.append(QString::number(level));
    currentClassList.append(QString::number(point));
    currentClassList.append(QString::number(health));
    currentClassList.append(QString::number(defence));
    currentClassList.append(QString::number(action));
    currentClassList.append(QString::number(strength));
    currentClassList.append(QString::number(movement));
}

void mainfunction::deleteClass(QString className) //This function is used for deleting class.
{
    currentClassList = null;
    classInfo.erase(className); //Erases the class data
    classNameList.removeOne(className); //Check make sure this doesn't act up.
    currentClass = "";
}

void mainfunction::classfinished() //This function is used after the data is stored on to currentClassList
{
    classInfo[currentClass] = currentClassList; //Adds the class data(list) to classInfo(passing the class name)
    currentClassList = null;
    currentClass = "";
}

void mainfunction::setClassValue(QString value)
{
    currentClassList.append(value);
}

int mainfunction::getClassListLength() //This function is used for counting how many classes there are. It is used for for-loops in the allClassView.qml file when displaying classes
{
    //return classInfo.size();
    return classNameList.length();
}

int mainfunction::getClassListLength(QString name) //This function is used for counting how many datas there are in each class data(list). Please note, getClassListLength() and this function are not same.
{
    return classInfo[name].length();
}

QString mainfunction::getClassName(int at)
{
    return classNameList.at(at);
}

int mainfunction::getClassLevel(int a)
{
    return classInfo[classNameList.at(a)].at(1).toInt();
}

int mainfunction::getClassLevel(QString name)
{
    return classInfo[name].at(1).toInt();
}

int mainfunction::getClassPoints(int a)
{
    return classInfo[classNameList.at(a)].at(2).toInt();
}

int mainfunction::getClassPoints(QString name)
{
    return classInfo[name].at(2).toInt();
}

int mainfunction::getClassHealth(QString name)
{
    return classInfo[name].at(3).toInt();
}

int mainfunction::getClassDefence(QString name)
{
    return classInfo[name].at(4).toInt();
}

int mainfunction::getClassAction(QString name)
{
    return classInfo[name].at(5).toInt();
}

int mainfunction::getClassStrength(QString name)
{
    return classInfo[name].at(6).toInt();
}

int mainfunction::getClassMovement(QString name)
{
    return classInfo[name].at(7).toInt();
}

QString mainfunction::getSkill(QString name, int a)
{
    return classInfo[name].at(a);
}

//LOADOUT - For these functions refer to the CLASS functions, Loadout functions have the same name and functionailty just different first word (class and loadout) is changed.

void mainfunction::createLoadout(QString loadoutName, int point)
{
    currentLoadoutList = null;
    currentLoadout = loadoutName;
    currentLoadoutList.append(loadoutName);
    if(!(loadoutNameList.contains(loadoutName)))
    {
        loadoutNameList.append(loadoutName);
    }else{
        loadoutInfo.erase(loadoutName);
    }
    currentLoadoutList.append(QString::number(point));
}

void mainfunction::deleteLoadout(QString loadoutName)
{
    currentLoadoutList = null;
    loadoutInfo.erase(loadoutName);
    loadoutNameList.removeOne(loadoutName); //Check make sure this doesn't act up.
    currentLoadout = "";
}

void mainfunction::loadoutfinished()
{
    loadoutInfo[currentLoadout] = currentLoadoutList;
    currentLoadoutList = null;
    currentLoadout = "";
}

void mainfunction::setLoadoutValue(QString value)
{
    currentLoadoutList.append(value);
}

int mainfunction::getLoadoutListLength()
{
    //return classInfo.size();
    return loadoutNameList.length();
}

int mainfunction::getLoadoutListLength(QString name)
{
    return loadoutInfo[name].length();
}

QString mainfunction::getLoadoutName(int at)
{
    return loadoutNameList.at(at);
}

int mainfunction::getLoadoutPoints(int a)
{
    return loadoutInfo[loadoutNameList.at(a)].at(1).toInt();
}

int mainfunction::getLoadoutPoints(QString name)
{
    return loadoutInfo[name].at(1).toInt();
}

QString mainfunction::getLoadout(QString name, int a)
{
    return loadoutInfo[name].at(a);
}

//ARMY - For these functions refer to the CLASS functions, Army functions have the same name and functionailty just first word (class and army) is changed.

void mainfunction::createArmy(QString name, int points)
{

}

//FILES - These two functions are used for outputting/inputting class data to either .xml file or to the functions above.

void mainfunction::outputFile() //This funcion is used for outputting [] data to a .xml file
{
    QFile file(documentFolder);
    file.open(QIODevice::ReadWrite);
    file.resize(0);
    QXmlStreamWriter writer(&file);
    writer.setAutoFormatting(true);
    writer.writeStartDocument();
        writer.writeStartElement("Skrimish_Engine");
            writer.writeStartElement("Class");
                for(int a = 0; a < classNameList.count(); a++)
                {
                    writer.writeStartElement("Class_" + QString::number(a));
                    writer.writeTextElement("Name", classNameList.at(a));
                    writer.writeTextElement("Level", QString::number(getClassLevel(classNameList.at(a))));
                    writer.writeTextElement("Points", QString::number(getClassPoints(classNameList.at(a))));
                    writer.writeTextElement("Health", QString::number(getClassHealth(classNameList.at(a))));
                    writer.writeTextElement("Defense", QString::number(getClassDefence(classNameList.at(a))));
                    writer.writeTextElement("Action", QString::number(getClassAction(classNameList.at(a))));
                    writer.writeTextElement("Strength", QString::number(getClassStrength(classNameList.at(a))));
                    writer.writeTextElement("Movement", QString::number(getClassMovement(classNameList.at(a))));
                    for(int b = 8; b < getClassListLength(classNameList.at(a)); b++)
                    {
                        writer.writeTextElement("Class_" + QString::number(b - 8), getSkill(classNameList.at(a), b));
                    }
                    writer.writeEndElement();
                }
            writer.writeEndElement();
            writer.writeStartElement("Loadout");
                for(int a = 0; a < loadoutNameList.count(); a++)
                {
                    writer.writeStartElement("Class_" + QString::number(a));
                    writer.writeTextElement("Name", loadoutNameList.at(a));
                    writer.writeTextElement("Points", QString::number(getLoadoutPoints(loadoutNameList.at(a))));
                    for(int b = 2; b < getLoadoutListLength(loadoutNameList.at(a)); b++)
                    {
                        writer.writeTextElement("Loadout_" + QString::number(b - 2), getLoadout(loadoutNameList.at(a), b));
                    }
                    writer.writeEndElement();
                }
            writer.writeEndElement();
            writer.writeStartElement("Army");
            writer.writeEndElement();
        writer.writeEndElement();
    writer.writeEndDocument();
    file.close();
}

QString mainfunction::getString() //Used only for debugging, this function is called in .qml files
{
    return debug;
}

void mainfunction::inputFile() //This function is used for getting [] data from .xml file
{
    QFile file(documentFolder);

    file.open(QIODevice::ReadWrite);

    QXmlStreamReader reader(&file);
    if(reader.readNextStartElement())
    {
        if(reader.name() == "Skrimish_Engine")
        {
            while(reader.readNextStartElement())
            {
                if(reader.name() == "Class")
                {
                    while(reader.readNextStartElement())
                    {
                        currentClassList = null;
                        while(reader.readNextStartElement())
                        {
                            if(reader.name() == "Name")
                            {
                                currentClass = reader.readElementText();
                                currentClassList.append(currentClass);
                            }else{
                                currentClassList.append(reader.readElementText());
                            }
                        }
                        classNameList.append(currentClass);
                        classfinished();
                    }
                }
                if(reader.name() == "Loadout")
                {
                    while(reader.readNextStartElement())
                    {
                        currentLoadoutList = null;
                        while(reader.readNextStartElement())
                        {
                        if(reader.name() == "Name")
                        {
                            currentLoadout = reader.readElementText();
                            currentLoadoutList.append(currentLoadout);
                        }else{
                            currentLoadoutList.append(reader.readElementText());
                        }
                        }
                        loadoutNameList.append(currentLoadout);
                        loadoutfinished();
                    }
                }
                if(reader.name() == "Army")
                {

                }
            }
        }
    }
}
