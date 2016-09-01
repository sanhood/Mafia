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
    players[0].role = "mafia"
    players[0].send("mafia")
    players[1].role = "police"
    players[1].send("police")
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
    sendToAll("result")
    sleep(2)
    var max = 0
    var index : Int?
    for x in 0...players.count - 1 {
        if players[x].numberOfVotes > max {
            max = players[x].numberOfVotes
            index = x
        }
        players[x].numberOfVotes = 0
    }
    
    if let ind = index {
        players[ind].send("eliminated")
        usleep(300000)
        sendToAll(players[ind].name)
        players[ind].isEliminated = true
        }
    
}

func gameOver () -> Bool {
    return false
}

func sendToAliveMafias (d : String) {
    for player in players {
        if player.isEliminated == false && player.role == "mafia" {
            player.send(d)
        }
    }
}

func day () {
    sendToAll("day")
    sleep(2)
    tof = true
    for player in players {
        if player.isEliminated == false {
            player.receive() }
    }
    for player in players {
        sendToAll("vote"+player.name)
        player.isVoting = true
        sleep(5)
        player.isVoting = false
        
    }
    tof = false
}

func night () {
    sendToAll("night")
    sleep(2)
    tof = true
    for player in players {
        if player.isEliminated == false && player.role == "mafia" {
            player.receive()
        }}
    for player in players {
        if player.isEliminated == false {
            sendToAliveMafias("vote"+player.name)
            player.isVoting = true
            sleep(5)
            player.isVoting = false}
        
    }
    tof = false
}


func game(){
   // while !gameOver() {
    day()
    eliminatePlayer()
    sleep(5)
    night()
    eliminatePlayer()
    sleep(5)
    day()
    }
    
    
    
    
    
    
  //  }






setUpServer()
acceptPlayer()
sleep(3)
assignRoles()
sleep(1)
displayMafiaToMafia()
sleep(10)
game()





let stdinput=NSFileHandle.fileHandleWithStandardInput()
    stdinput.readDataToEndOfFile()

