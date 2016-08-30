import Foundation
import Darwin.C

var n = 3
var players : [Player] = []
let server:TCPServer = TCPServer(addr: "192.168.1.105", port: 8080)
var tof = true



func setUpServer() -> Bool {
    
    let (success,_) = server.listen()
    if success {
        print("server started")
    }
    return success
}

func receive (player : Player) -> String {
    return player.read()
}

func acceptPlayer ( ) {
    var counter = 0
    while counter < n {
        let client = server.accept()
        let name = client!.read(1024*10)
        let newPlayer = Player(client: client! , name: name!)
        players.append(newPlayer)
        for player1 in players {
            for player2 in players {
                if(player1.name != (player2.name)){
                    player1.send((player2.name))
                    usleep(10000)
                }
            }
        }
        counter++
         }
        sleep(3)
        sendToAll("rolevc")
}





func processData (d : String) {
    print(d)
}


func assignRoles ( ) {
    players[0].role = "police"
    players[0].send("police")
    players[1].role = "mafia"
    players[1].send("mafia")
    players[2].role = "mafia"
    players[2].send("mafia")
}

func displayMafiaToMafia () {
    for player1 in players {
        if player1.role == "mafia" {
            for player2 in players {
                if player2.role == "mafia" && player2.name != player1.name{
                    player1.send(player2.name)
                    usleep(100000)

            }
        }
    }
}
}

func sendToAll (d : String) {
    for player in players {
        player.send(d)
    }
}

func eliminatePlayer () {
    var max = 0
    var index : Int?
    for x in 0...players.count - 1 {
        if players[x].numberOfVotes > max {
            max = players[x].numberOfVotes
            index = x
        }
    }
    if let ind = index {
        players.removeAtIndex(ind)
        }
}


func game(){
    for player in players {
        player.recieve()
    }
       for player in players {
            sendToAll("vote"+player.name)
            player.isVoting = true
            sleep(15)
            player.isVoting = false
            
    }
    tof = false
    
    for player in players {
        print(player.name + "\(player.numberOfVotes)")
    }
    
    eliminatePlayer()

}




setUpServer()
acceptPlayer()
sleep(3)
assignRoles()
sleep(1)
displayMafiaToMafia()
sleep(10)
sendToAll("dayone")
sleep(2)
game()





let stdinput=NSFileHandle.fileHandleWithStandardInput()
    stdinput.readDataToEndOfFile()

