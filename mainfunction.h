#ifndef MAINFUNCTION_H
#define MAINFUNCTION_H

#include <QObject>
#include <QStandardPaths>
#include <QDebug>
#include <QList>
#include <map>
#include <QFile>
#include <QXmlStreamWriter>
#include <QXmlStreamReader>

class mainfunction : public QObject
{
    Q_OBJECT
public:
    //Q_INVOKABLE needs to be used when communicating with the qml files.
    explicit mainfunction(QObject *parent = 0);
    ~mainfunction();
    Q_INVOKABLE void createClass(QString className, int level, int point, int health, int defence, int action, int strength, int movement);
    Q_INVOKABLE void deleteClass(QString className);
    Q_INVOKABLE void setClassValue(QString value);
    Q_INVOKABLE void classfinished();
    Q_INVOKABLE int getClassListLength();
    Q_INVOKABLE int getClassListLength(QString name);
    Q_INVOKABLE QString getClassName(int at);
    Q_INVOKABLE int getClassLevel(int a);
    Q_INVOKABLE int getClassLevel(QString name);
    Q_INVOKABLE int getClassPoints(int a);
    Q_INVOKABLE int getClassPoints(QString name);
    Q_INVOKABLE int getClassHealth(QString name);
    Q_INVOKABLE int getClassDefence(QString name);
    Q_INVOKABLE int getClassAction(QString name);
    Q_INVOKABLE int getClassStrength(QString name);
    Q_INVOKABLE int getClassMovement(QString name);
    Q_INVOKABLE QString getSkill(QString name, int a);

    Q_INVOKABLE void createLoadout(QString loadoutName, int point);
    Q_INVOKABLE void deleteLoadout(QString loadoutName);
    Q_INVOKABLE void setLoadoutValue(QString value);
    Q_INVOKABLE void loadoutfinished();
    Q_INVOKABLE int getLoadoutListLength();
    Q_INVOKABLE int getLoadoutListLength(QString name);
    Q_INVOKABLE QString getLoadoutName(int at);
    Q_INVOKABLE int getLoadoutPoints(int a);
    Q_INVOKABLE int getLoadoutPoints(QString name);
    Q_INVOKABLE QString getLoadout(QString name, int a);

    Q_INVOKABLE void createArmy(QString name, int points);

    Q_INVOKABLE void outputFile();
    Q_INVOKABLE void inputFile();

    Q_INVOKABLE QString getString();

private:
    std::map<QString, QList<QString>> classInfo; //map or Hashmaps are basically like dictionaries in python or javascript
    QList<QString> currentClassList;
    QList<QString> classNameList;
    QList<QString> null; //Null list, only used when setting up a new []. (IMPORTANT: Do not append any QString into this list!)
    QString currentClass = "";
    QString debug;

    std::map<QString, QList<QString>> loadoutInfo;
    QList<QString> currentLoadoutList;
    QList<QString> loadoutNameList;
    QString currentLoadout = "";
    QString documentFolder = QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation).at(0) + "/SkrmishEngine.xml"; //This is used to find the document folder. In iOS, document folder is the only place that can be used for storing data(in .xml).

    std::map<QString, QList<QString>> characterInfo;
    QList<QString> currentCharacterList;
    QList<QString> characterNameList;
    QString currentCharacter = "";

    std::map<QString, QList<QString>> armyInfo;
    QList<QString> currentArmyList;
    QList<QString> armyNameList;
    QString currentArmy = "";
};

#endif // MAINFUNCTION_H
