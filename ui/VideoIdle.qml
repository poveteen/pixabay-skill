/*
 * Copyright 2020 by Aditya Mehra <aix.m@outlook.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

import QtQuick.Layouts 1.4
import QtQuick 2.9
import QtQuick.Controls 2.12 as Controls
import QtQuick.Window 2.2
import org.kde.kirigami 2.8 as Kirigami
import Mycroft 1.0 as Mycroft
import QtMultimedia 5.12

Item {
    id: rootVideo
    anchors.fill: parent
    
    Timer {
        id: dTimeTimer
        running: idleLoaderView.showTime && rootVideo.visible ? 1 : 0
        repeat: idleLoaderView.showTime && idleLoaderView.visible ? 1 : 0
        interval: 10000
        onTriggered: {
            console.log("dTimeTimer Triggered, should get updated Time")
            triggerGuiEvent("pixabay.idle.updateTime", {})
        }
    }

    Video {
        id: video
        anchors.fill: parent
        focus: true
        autoLoad: true
        autoPlay: true
        loops: MediaPlayer.Infinite
        fillMode: VideoOutput.Stretch
        source: Qt.resolvedUrl(idleLoaderView.idleGenericURL)
        
        Controls.Label {
            id: time
            anchors.centerIn: parent
            font.capitalization: Font.AllUppercase
            font.family: "Noto Sans Display"
            font.weight: Font.Bold
            font.pixelSize: 140
            enabled: idleLoaderView.showTime
            visible: idleLoaderView.showTime
            color: "white"
            lineHeight: 0.6
            text: idleLoaderView.time_string.replace(":", "꞉")
        }
    }
}
