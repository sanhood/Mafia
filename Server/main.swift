import Foundation
import Darwin.C

var clients : [TCPClient] = []

func sendToAll (d : [UInt8]) {
    for client in clients {
       client.send(data: d)
    }
}

func send(client:TCPClient , d : [UInt8]) {
    client.send(data: d)
}
func setUpServer() -> Bool {
    let server:TCPServer = TCPServer(addr: "192.168.1.107", port: 8080)
    let (success,_) = server.listen()
    return success
}

func receive (client : TCPClient) -> [UInt8] {
    return client.read(1024*10)!
}











setUpServer()
let stdinput=NSFileHandle.fileHandleWithStandardInput()
stdinput.readDataToEndOfFile()

