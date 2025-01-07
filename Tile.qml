/*
 * SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 *
 * Based on org.kde.plasma.binaryclock main.qml, BinaryClock.qml:
 * SPDX-FileCopyrightText: 2014 Joseph Wenninger <jowenn@kde.org>
 * SPDX-FileCopyrightText: 2018 Piotr Kąkol <piotrkakol@protonmail.com>
 * SPDX-FileCopyrightText: 2023 Bharadwaj Raju <bharadwaj.raju777@protonmail.com>
 *
 * Original code (KDE4):
 * SPDX-FileCopyrightText: 2007 Riccardo Iaconelli <riccardo@kde.org>
 * SPDX-FileCopyrightText: 2007 Davide Bettio <davide.bettio@kdemail.net>
 *
 * Based on fuzzy-clock main.qml, FuzzyClock.qml:
 * SPDX-FileCopyrightText: 2013 Heena Mahour <heena393@gmail.com>
 * SPDX-FileCopyrightText: 2013 Sebastian Kügler <sebas@kde.org>
 * SPDX-FileCopyrightText: 2014 Kai Uwe Broulik <kde@privat.broulik.de>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasma5support 2.0 as P5Support

Item {
    id: root

    property int hours
    property int minutes
    property int seconds

    anchors.fill: parent
    anchors.margins: Kirigami.Units.smallSpacing

    required property var metadata
    required property var container

    function activate () {}

    P5Support.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        intervalAlignment: root.metadata.showSeconds ? P5Support.Types.NoAlignment : P5Support.Types.AlignToMinute
        interval: root.metadata.showSeconds ? 1000 : 60000

        onDataChanged: {
            let date = new Date(data["Local"]["DateTime"]);
            root.hours = date.getHours();
            root.minutes = date.getMinutes();
            root.seconds = date.getSeconds();
        }
        Component.onCompleted: {
            dataChanged();
        }
    }

    Rectangle {
        visible: root.metadata.showBackground
        anchors.fill: parent
        color: Kirigami.Theme.backgroundColor
        radius: root.metadata.roundedCorners ? Kirigami.Units.mediumSpacing : 0
    }

    ColumnLayout {
        anchors.fill: parent
        Item {
            id: main
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: Kirigami.Units.mediumSpacing

            readonly property real w1: (main.height-5*Kirigami.Units.smallSpacing)*dots/4

            Layout.minimumWidth: w1 < 20 ? 20 : w1
            Layout.maximumWidth: Infinity
            Layout.preferredWidth: Layout.minimumWidth

            Layout.minimumHeight: 16+(Kirigami.Units.smallSpacing*5)

            readonly property bool showSeconds: root.metadata.showSeconds

            readonly property int hours: root.hours
            readonly property int minutes: root.minutes
            readonly property int seconds: root.seconds

            readonly property int base: 10

            readonly property bool showOffLeds: root.metadata.showOffLeds

            readonly property int dots: showSeconds ? 6 : 4

            readonly property color onColor: root.metadata.useCustomColorForActive ? Qt.color(root.metadata.activeColor) : Kirigami.Theme.textColor
            readonly property color offColor: root.metadata.useCustomColorForInactive ? Qt.color(root.metadata.inactiveColor) : Qt.rgba(onColor.r, onColor.g, onColor.b, 0.2)

            readonly property int dotSize: Math.min((height-5*Kirigami.Units.smallSpacing)/4, (width-(dots+1)*Kirigami.Units.smallSpacing)/dots)

            GridLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                columns: main.showSeconds ? 6 : 4
                Repeater {
                    model: [8, 4, 2, 1]
                    Repeater {
                        model: [root.hours/main.base, root.hours%main.base, root.minutes/main.base, root.minutes%main.base, root.seconds/main.base, root.seconds%main.base]
                        property var bit: modelData
                        Rectangle {
                            property var timeVal: modelData
                            visible: main.dotSize >= 0 && (main.showSeconds || index < 4)
                            width: main.dotSize
                            height: width
                            radius: width/2
                            color: (timeVal & bit) ? main.onColor : (main.showOffLeds ? main.offColor : "transparent")
                        }
                    }
                }
            }
        }

    }
}
