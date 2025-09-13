import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: window
    width: 1000
    height: 700
    visible: true
    title: "Application de Gestion et de Préparation des Dossiers d'Affaires Judiciaires"
    color: "#1a1a1a"

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop { position: 0.0; color: "#1e3a5f" }
            GradientStop { position: 0.7; color: "#0f1e2e" }
            GradientStop { position: 1.0; color: "#020408" }
        }

        Canvas {
            anchors.fill: parent
            opacity: 0.3

            onPaint: {
                var ctx = getContext("2d")
                ctx.strokeStyle = "#000000"
                ctx.lineWidth = 1

                // Lignes verticales
                for (var x = 0; x < width; x += 10) {
                    ctx.beginPath()
                    ctx.moveTo(x, 0)
                    ctx.lineTo(x, height)
                    ctx.stroke()
                }

                // Lignes horizontales
                for (var y = 0; y < height; y += 10) {
                    ctx.beginPath()
                    ctx.moveTo(0, y)
                    ctx.lineTo(width, y)
                    ctx.stroke()
                }
            }
        }

        Rectangle {
            id: glareEffect
            width: 200  // Plus large
            height: 6000  // Longueur diagonale
            y: 0
            visible: false

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.5; color: "#b2dcf1" }
                GradientStop { position: 1.0; color: "transparent" }
            }

            transform: Rotation {
                angle: 25
                origin.x: 100
                origin.y: height/2
            }
        }

        Timer {
            id: glareTimer
            interval: 5000  // 5 secondes entre chaque passage
            running: true
            repeat: true

            onTriggered: {
                glareEffect.x = -glareEffect.width - 200  // Plus à gauche
                glareEffect.y = -2000  // Plus en haut
                glareEffect.visible = true
                glareAnimation.start()
            }
        }

        ParallelAnimation {
            id: glareAnimation

            NumberAnimation {
                target: glareEffect
                property: "x"
                to: window.width + glareEffect.width + 200
                duration: 3000
            }

            NumberAnimation {
                target: glareEffect
                property: "y"
                to: window.height + 200  // Vers le bas
                duration: 3000
            }

            onFinished: {
                glareEffect.visible = false
            }
        }

        Text {
            anchors.centerIn: parent
            text: "AGPDAJ - Système de Gestion des dossiers de la Police et de la Justice"
            color: "#ecf0f1"
            font.pixelSize: 32
            font.bold: true
        }

        Rectangle {
            width: 200
            height: 50
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 100
            radius: 25
            color: mouseArea.pressed ? "#2980b9" : "#3498db"

            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            Text {
                anchors.centerIn: parent
                text: "Employés"
                color: "white"
                font.pixelSize: 18
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: console.log("Module Employés cliqué!")
            }
        }
    }
}
