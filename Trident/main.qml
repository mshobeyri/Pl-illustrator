import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import Qt.labs.settings 1.0

ApplicationWindow {
    visible: true
    width: 380
    height: 640
    title: qsTr("Demon Trident")
    Material.accent: "#7f0000"
    Material.theme: Material.Dark

    property string imageData: ""
    property string notes: ""
    property alias framesCombo: iframesCombo

    header: ToolBar{
        topPadding: 0
        Layout.fillWidth: true
        Material.background: Material.accent
        RowLayout{
            width: parent.width
            Image{
                source: "qrc:/../res/tridnetLogoCaption.png"
                Layout.preferredHeight: parent.height/1.7
                fillMode: Image.PreserveAspectFit
            }

            Item{
                Layout.fillWidth: true
            }

            ToolButton{
                font.family: ifontAwsome.name
                text: "wifi"
                onClicked: iconnectionSetting.open()
                Rectangle{
                    width: parent.width/5
                    height: width
                    radius: width
                    color: iconnection.isConnected?"green":"red"
                    anchors{
                        right: parent.right
                        bottom: parent.bottom
                        rightMargin: 10
                        bottomMargin: 10
                    }
                }
            }
        }
    }
    Settings{
        id: isettings

        property alias laserColor: ilaserSetting.color
        property alias laserSize: ilaserSetting.size
        property alias noteSize: inotesSetting.noteSize
        property alias ip: iconnectionSetting.ip
        property alias port: iconnectionSetting.port
        property alias url: iconnection.url
    }

    FontLoader{
        id: ifontAwsome
        source: "qrc:/../res/Font Awesome 5 Pro-Solid-900.otf"
    }

    Connection{
        id: iconnection
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 10
        RowLayout{
            Layout.fillWidth: true
            Label{
                text: "LASER"
                font.pointSize: 14
                Material.foreground: Material.accent
            }
            Item{
                Layout.fillWidth: true
            }

            ToolButton{
                font.family: ifontAwsome.name
                text: "cog"
                onClicked: ilaserSetting.open()
            }
        }
        Frame{
            Layout.fillWidth: true
            Layout.preferredHeight: (parent.width - 20) *9/16
            Material.elevation: 7
            padding: 1
            topPadding: 1
            bottomPadding: 1
            MouseArea{
                anchors.fill: parent
                onReleased: iconnection.fakeLaser(-1,-1)
                onMouseXChanged: containsMouse?
                                     iconnection.fakeLaser(mouseX/width,mouseY/height):
                                     iconnection.fakeLaser(-1,-1)

                onMouseYChanged: containsMouse?
                                     iconnection.fakeLaser(mouseX/width,mouseY/height):
                                     iconnection.fakeLaser(-1,-1)


            }
            Image{
                visible: iimage.status !== Image.Ready
                width: parent.width/1.5
                height: parent.height/1.5
                source: "qrc:/../res/logo.png"
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
            }

            Image{
                id: iimage
                anchors.fill: parent
                fillMode: Image.Stretch
                source: imageData!==""?"data:image/png;base64," + imageData:""
            }
        }
        RowLayout{
            Layout.fillWidth: true
            Layout.topMargin: 20
            Label{
                text: "Notes"
                font.pointSize: 14
                Material.foreground: Material.accent
            }
            Item{
                Layout.fillWidth: true
            }

            ToolButton{
                font.family: ifontAwsome.name
                text: "cog"
                onClicked: inotesSetting.open()
            }
        }
        Flickable{
            contentHeight: inotes.paintedHeight
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            interactive: contentHeight>height
            Label{
                id: inotes

                font.pointSize: inotesSetting.noteSize
                wrapMode: "WordWrap"
                text: notes!==""?notes : "No Note Available"
            }
        }
    }

    LaserSettings{
        id: ilaserSetting
    }
    NotesSettings{
        id: inotesSetting
    }
    ConnectionSetting{
        id: iconnectionSetting
    }

    footer: ToolBar{
        Material.background: Material.accent
        RowLayout{
            width: parent.width
            ToolButton{
                font.family: ifontAwsome.name
                text: "angle-left"
                onClicked: iconnection.goPrev()
            }
            ToolButton{
                font.family: ifontAwsome.name
                text: "angle-right"
                onClicked: iconnection.goNext()
            }
            ComboBox{
                id: iframesCombo

                Layout.fillWidth: true
                Layout.rightMargin: 10
                flat: true
                currentIndex: 0
                indicator.rotation: 180
                delegate: MenuItem{
                    width: parent.width
                    text: modelData
                    onClicked: iconnection.goTo(index+1)
                    highlighted: iframesCombo.highlightedIndex === index
                }
            }
        }
    }
}
