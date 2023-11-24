//
//  Messagesviewmodel.swift
//  modulecoachingpriv
//
//  Created by Farah Metoui on 21/11/2023.
//

import Foundation
import SocketIO
import SwiftUI
class Messagesviewmodel :  ObservableObject{
    @EnvironmentObject var user : Userviewmodel

    @Published var messages: [Messages] = []
    var socket =  SocketManager(socketURL: URL(string: "http://192.168.1.4:3000")!)
    let socketURL = "http://192.168.1.4:3000"
    var msocket: SocketIOClient!
     init() {
        // super.init()
        // Initialize and connect to Socket.IO server
        // Replace with your server URL
        
        msocket = socket.defaultSocket
        

        // msocket.connect()
    }
    func getSocket() -> SocketIOClient {
        return msocket
    }
    func establishConnection(userid:String) {
        msocket.connect()
        
           
        
                receiveMessage()
    }
    func connectionestablished(userid:String){
        self.msocket.emit("userConnected", userid)
    }
    func closeConnection() {
        msocket.disconnect()
    }
    
    func sendMessage(senderID: String, receiverID: String, message: String) {
        
        let messageData: [String: Any] = [
            "sender": senderID,
            "recipient": receiverID,
            "content": message,
            
        ]
        
        msocket.emit("sendMessage", messageData)
    }
    
    func receiveMessage() {
        msocket.on("receiveMessage") { data, ack in
            print("1111")
            if let jsonArray = data as? [[String: Any]] {
                print("2222")

                    // Handle the received JSON array of messages
                for jsonData in jsonArray {
                    // Parse each message from the JSON data
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonData, options: [])
                        let decoder = JSONDecoder()
                        let message = try decoder.decode(Messages.self, from: jsonData)
                        
                        
                        print("Received message: \(message)")
                        
                        // Append the received message to your messages array
                        self.messages.append(message)
                        
                      
                    } catch {
                        print("Error decoding message: \(error)")
                    }
                }
            }
        }
    }
}
