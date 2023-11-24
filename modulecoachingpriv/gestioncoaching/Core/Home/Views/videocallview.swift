//
//  videocallview.swift
//  modulecoachingpriv
//
//  Created by Farah Metoui on 16/11/2023.
//

import SwiftUI
import Alamofire
struct videocallview: View {
   
 
    var signalClient : SignalingClient

    @Environment(\.presentationMode) var presentationMode
   
     var webRTCClient: WebRTCClient
    init(webRTCClient: WebRTCClient,signalClient: SignalingClient) {
        self.webRTCClient = webRTCClient
        self.signalClient = signalClient
    }

   

    var body: some View {
        // Your WebRTC client instance
        
       
            VStack {
                ZStack{
                    RTCVideoRepresentable( webRTCClient: webRTCClient,isLocal: true)
                        .frame(width: UIScreen.main.bounds.width, height: 500)
                        .edgesIgnoringSafeArea(.all)
                    Button(action: {
                        
                        signalClient.discconnect()
                        presentationMode.wrappedValue.dismiss()
                        presentationMode.wrappedValue.dismiss()
                        
                        }){ Image(systemName: "xmark")
                            .font(.title) // Adjust the font size if needed
                            .foregroundColor(.red)
                            .padding(25) }.position(x:60,y:110)
                }
                RTCVideoRepresentable( webRTCClient: webRTCClient,isLocal: false)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 500)
                    .edgesIgnoringSafeArea(.all)
                
                Spacer()
                
                .padding()
            }
        }
  
    }

/*#Preview {
    videocallview()
}*/

