import Foundation
import Darwin.C

var players : [Player] = []
let server:TCPServer = TCPServer(addr: "192.168.1.107", port: 8080)
func sendToAll (d : AnyObject) {
    
    if (server.gameState == -1 ){
        let data = d as! [Player]
    for player1 in data {
        for player2 in data {
        if(player1.name != (player2.name)){
            player1.send((player2.name))
            }
        
        }
        }}
}
        




func send(client:TCPClient , d : [UInt8]) {
    client.send(data: d)
}
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
    for x in 0...1 {
        let client = server.accept()
        let name = client!.read(1024*10)
        let newPlayer = Player(client: client! , name: name!)
        players.append(newPlayer)
        if (x == 0) {
            firstPlayerJoins() }
        else {
            waitingForPlayersToJoin()
        }
        sendToAll(players)
         }
    

}





func processData (d : String) {
    print(d)
}


func firstPlayerJoins () {
    server.gameState = -2
    print(#function)
}

func waitingForPlayersToJoin () {
    server.gameState = -1
    print(#function)
}







setUpServer()
acceptPlayer()
let stdinput=NSFileHandle.fileHandleWithStandardInput()
stdinput.readDataToEndOfFile()

