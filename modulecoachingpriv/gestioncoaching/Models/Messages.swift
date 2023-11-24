//
//  Messages.swift
//  modulecoachingpriv
//
//  Created by Farah Metoui on 20/11/2023.
//

import Foundation
struct Messages: Codable,Hashable {
    let id: Int?
    let sender: String
    let recipient : String
    let content: String
    let timestamp: Date?
    init(id: Int, sender: String, recipient: String, content: String) {
           self.id = id
           self.sender = sender
           self.recipient = recipient
           self.content = content
           self.timestamp = Date() // Assigns the current system timestamp if not provided
       }
}
