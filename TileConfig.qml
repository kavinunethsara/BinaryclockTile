/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtCore
import org.kde.kirigamiaddons.formcard as FormCard
import QtQuick.Dialogs as Dialogs

FormCard.FormCardPage {
    id: root
    anchors.fill: parent
    required property variant config

    FormCard.FormHeader {
        title: "General"
    }
    FormCard.FormCard {
        FormCard.FormSpinBoxDelegate {
            label: "Width"
            value: config.width
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                config.width = value
            }
        }
        FormCard.FormSpinBoxDelegate {
            label: "Height"
            value: config.height
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                config.height = value
            }
        }
        FormCard.FormSwitchDelegate {
            text: "Show seconds"
            checked: config.showSeconds
            onCheckedChanged: {
                config.showSeconds = checked
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
            checked: config.showBackground
            onCheckedChanged: {
                config.showBackground = checked
            }
        }
        FormCard.FormSwitchDelegate {
            text: "Rounded Corners"
            enabled: showBackground.checked
            checked: config.roundedCorners
            onCheckedChanged: {
                config.roundedCorners = checked
            }
        }
        FormCard.FormSwitchDelegate {
            text: "Show inactive LEDs"
            checked: config.showOffLeds
            onCheckedChanged: {
                config.showOffLeds = checked
            }
        }
        FormCard.FormSwitchDelegate {
            id: customActive
            text: "Custom active LED color"
            checked: config.useCustomColorForActive
            onCheckedChanged: {
                config.useCustomColorForActive = checked
            }
        }
        FormCard.FormColorDelegate {
            enabled: customActive.checked
            text: "Active LED Color"
            color: config.activeColor
            onColorChanged: {
                config.activeColor = color.toString()
            }
        }
        FormCard.FormSwitchDelegate {
            id: customInactive
            text: "Custom active LED color"
            checked: config.useCustomColorForInactive
            onCheckedChanged: {
                config.useCustomColorForInactive = checked
            }
        }
        FormCard.FormColorDelegate {
            enabled: customInactive.checked
            text: "Active LED Color"
            color: config.inactiveColor
            onColorChanged: {
                config.inactiveColor = color.toString()
            }
        }
    }
}
