/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtCore
import org.kde.kirigamiaddons.formcard as FormCard
import QtQuick.Dialogs as Dialogs

FormCard.FormCardPage {
    id: root
    anchors.fill: parent
    required property var tile

    FormCard.FormHeader {
        title: "General"
    }
    FormCard.FormCard {
        FormCard.FormSpinBoxDelegate {
            label: "Width"
            value: root.tile.model.tileWidth
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                root.tile.model.tileWidth = value;
            }
        }
        FormCard.FormSpinBoxDelegate {
            label: "Height"
            value: root.tile.model.tileHeight
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                root.tile.model.tileHeight = value;
            }
        }
        FormCard.FormSwitchDelegate {
            text: "Show seconds"
            checked: root.tile.tileData.showSeconds
            onCheckedChanged: {
                root.tile.tileData.showSeconds = checked;
                root.tile.tileData = root.tile.tileData; // This is required fot tileData to be refreshed
            }
        }
    }

    FormCard.FormHeader {
        title: "Appearance"
    }

    FormCard.FormCard {
        FormCard.FormSwitchDelegate {
            id: showBackground
            text: "Show Background"
            checked: root.tile.tileData.showBackground
            onCheckedChanged: {
                root.tile.tileData.showBackground = checked;
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormSwitchDelegate {
            text: "Rounded Corners"
            enabled: showBackground.checked
            checked: root.tile.tileData.roundedCorners
            onCheckedChanged: {
                root.tile.tileData.roundedCorners = checked;
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormSwitchDelegate {
            text: "Show inactive LEDs"
            checked: root.tile.tileData.showOffLeds
            onCheckedChanged: {
                root.tile.tileData.showOffLeds = checked;
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormSwitchDelegate {
            id: customActive
            text: "Custom active LED color"
            checked: root.tile.tileData.useCustomColorForActive
            onCheckedChanged: {
                root.tile.tileData.useCustomColorForActive = checked;
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormColorDelegate {
            enabled: customActive.checked
            text: "Active LED Color"
            color: root.tile.tileData.activeColor
            onColorChanged: {
                root.tile.tileData.activeColor = color.toString();
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormSwitchDelegate {
            id: customInactive
            text: "Custom active LED color"
            checked: root.tile.tileData.useCustomColorForInactive
            onCheckedChanged: {
                root.tile.tileData.useCustomColorForInactive = checked;
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormColorDelegate {
            enabled: customInactive.checked
            text: "Active LED Color"
            color: root.tile.tileData.inactiveColor
            onColorChanged: {
                root.tile.tileData.inactiveColor = color.toString();
                root.tile.tileData = root.tile.tileData;
            }
        }
    }
}
