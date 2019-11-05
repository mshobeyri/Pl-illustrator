import QtQuick 2.12
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer

    property int rows: 3
    property int cols: 2
    property color sepratorsColor: "#9cb26a6a"
    property color backgroundColor: "#584f4f"
    property color textColor: "white"
    property int spacing: 4
    property font textFont
    property int textJustify: TextEdit.AlignLeft
    property var json: {
        "type":Element.table,
        "common": icontainer.commonData,
        "sepratorsColor": icontainer.sepratorsColor.toString(),
        "backgroundColor": icontainer.backgroundColor.toString(),
        "textColor": icontainer.textColor.toString(),
        "spacing": icontainer.spacing,
        "textFont": icontainer.textFont,
        "textJustify": icontainer.textJustify
    }
    function fromJson(json){
        sepratorsColor = json.sepratorsColor
        backgroundColor = json.backgroundColor
        textColor = json.textColor
        spacing = json.spacing
        textJustify = json.textJustify
        textFont.family = json.textFont.family
        textFont.bold = json.textFont.bold
        textFont.italic = json.textFont.italic
        textFont.pointSize = json.textFont.pointSize
    }
    onDoubleClicked:{
        editMode = true
        currentElement = icontainer
    }
    onSelectedChanged: {
        if(!selected)
            editMode = false
    }

    component:  Component {
        Rectangle{
            id: irect

            color: sepratorsColor
            clip: true
            Grid{
                id: igrid
                anchors{
                    fill: parent
                    margins: icontainer.spacing
                    rightMargin: 0
                    bottomMargin: 0
                }
                rows: icontainer.rows
                columns: icontainer.cols
                spacing: icontainer.spacing
                Repeater{
                    model: icontainer.rows* icontainer.cols
                    Item{
                        width: (igrid.width/icontainer.cols)-icontainer.spacing
                        height: (igrid.height/icontainer.rows)-icontainer.spacing
                        Rectangle{
                            anchors.fill: parent
                            color: icontainer.backgroundColor
                            anchors.centerIn: parent
                            TextEdit {
                                anchors.fill: parent
                                anchors.margins: icontainer.spacing
                                color:icontainer.textColor
                                enabled: editMode
                                text: "text"
                                font: icontainer.textFont
                                wrapMode: TextEdit.WordWrap
                                horizontalAlignment: textJustify
                                verticalAlignment: TextEdit.AlignVCenter
                            }
                        }
                    }
                }
            }
        }
    }
}
