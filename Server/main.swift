import Foundation
import Darwin.C
var n = 1
var players : [Player] = []
let server:TCPServer = TCPServer(addr: "192.168.1.132", port: 8080)




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
                // sleep(1)
                if(player1.name != (player2.name)){
                    player1.send((player2.name))
                    usleep(10000)
                }
            }
        }
        counter++
         }
        sleep(1)
        print("server closed")
}





func processData (d : String) {
    print(d)
}


func assignRoles ( ) {
    players[0].role = "police"
    players[0].send("police")
   // players[1].role = "mafia"
   // players[1].send("mafia")
   // players[2].role = "mafia"
   // players[2].send("mafia")
    print("sent")
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
func game(){
    let delayInSeconds = 8.0
    
    let GlobalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    
        for player in players {
             sendToAll("vote")
             sendToAll(player.name)
            dispatch_async(GlobalQueue){
                for player in players {
                    player.recieve()
                    sendToAll(player.recievedContent)
                }
            }
            sleep(8)
            
    }
    
}




setUpServer()
acceptPlayer()
assignRoles()
displayMafiaToMafia()
sleep(5)
sendToAll("dayone")
game()




let stdinput=NSFileHandle.fileHandleWithStandardInput()
stdinput.readDataToEndOfFile()

