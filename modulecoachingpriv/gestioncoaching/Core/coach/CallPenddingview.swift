//
//  CallPenddingview.swift
//  modulecoachingpriv
//
//  Created by Farah Metoui on 17/11/2023.
//

import SwiftUI
import WebRTC
struct CallPenddingview: View {
    @State private var dismissfromcall = false
    @Environment(\.presentationMode) var presentationMode

    var signalClient : SignalingClient
var webRTCClient: WebRTCClient
    @StateObject var videoLogic : Videologic
    @State private var acceptcall = false
   init(webRTCClient: WebRTCClient, signalClient: SignalingClient) {
       self.webRTCClient = webRTCClient
       self.signalClient = signalClient
       let logic = Videologic(webRTCClient: webRTCClient, signalClient: signalClient)
           _videoLogic = StateObject(wrappedValue: logic)
       }

    var body: some View {
      
            VStack {
                Capsule()
                    .foregroundColor (Color(.systemGray5))
                    .frame(width: 48, height: 6)
                    .padding(.top,-25)
               
                ZStack {
                    Circle()
                        .fill(Color(hex: "00b36e")) // Circle color
                        .frame(width: 100, height: 100) // Circle size
                        .overlay(
                            Image("coach2") // Replace with your image name
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 95, height: 95) // Image size
                                .clipShape(Circle())
                                .padding(10) // Padding between the image and the circle
                        )
                }
                Text("Your Coach is calling") .font(.custom("arial", size: 24)) .padding(.top,10)
                  //  .bold()
                Text("iheb debbech") .font(.system(.subheadline)) .padding(.top,3)
                 //   .bold()
                HStack{
                    Button(action: {
                        acceptcall=false
                        signalClient.discconnect()
                        presentationMode.wrappedValue.dismiss() 
                        }){
                        Image(systemName: "video.fill")
                            .font(.title) // Adjust the font size if needed
                            .foregroundColor(.red)
                        .padding(25) }
                    Button(action: {
                        acceptcall=true
                        webRTCClient.answer { (localSdp) in
                            
                            videoLogic.hasLocalSdp = true
                            self.signalClient.send(sdp: localSdp)
                        }
                    })
                    { Image(systemName: "video.fill")
                            .font(.title) // Adjust the font size if needed
                            .foregroundColor(Color(hex: "075c29"))
                        .padding(25) }
                }
                .padding( .top,10)
                
                .cornerRadius(30)
                
            }.frame(width: UIScreen.main.bounds.width -
                    25,height: 350)
            .background (Color(hex: "e6f0ec"))
            .cornerRadius (10)
            .padding(.horizontal)
            .popover(isPresented: $acceptcall, arrowEdge: .leading, content: {videocallview(webRTCClient: webRTCClient,signalClient: signalClient).transition(.move(edge: .top)).background(Color.black.opacity(0.3))                   })
        }
    

    class Videologic: ObservableObject, SignalClientDelegate,WebRTCClientDelegate {
               
                
                @Published var signalingConnected = false
                    @Published var hasLocalSdp = false
                    @Published var localCandidateCount = 0
                    @Published var hasRemoteSdp = false
                    @Published var remoteCandidateCount = 0
                    @Published var speakerOn = false
                    @Published var mute = false
                    @Published var webRTCStatus = "New"
                 var signalClient : SignalingClient
            var webRTCClient: WebRTCClient
                init(webRTCClient: WebRTCClient, signalClient: SignalingClient) {
                    self.webRTCClient = webRTCClient
                    self.signalClient = signalClient
                        self.webRTCClient.delegate = self
                        self.signalClient.delegate = self
                    }
                func webRTCClient(_ client: WebRTCClient, didReceiveDatastring data: String) {
                    print("idk ")
                    
                }
                func signalClient(_ signalClient: SignalingClient, didReceiveConnectedClientsCount count: Int) {
                    print("connected: \(count)")
                }
                
                func signalClientDidConnect(_ signalClient: SignalingClient) {
                 print("tesst")
                    DispatchQueue.main.async {
                        self.signalingConnected = true
                    }
                }
                
                func signalClientDidDisconnect(_ signalClient: SignalingClient) {
                    DispatchQueue.main.async {
                        self.signalingConnected = false
                    }
                }
                
                func signalClient(_ signalClient: SignalingClient, didReceiveRemoteSdp sdp: RTCSessionDescription) {
                    print("Received remote sdp")
                    DispatchQueue.main.async {
                        self.webRTCClient.set(remoteSdp: sdp) { (error) in
                            self.hasRemoteSdp = true
                        }
                    }
                }
                
                func signalClient(_ signalClient: SignalingClient, didReceiveCandidate candidate: RTCIceCandidate) {
                    DispatchQueue.main.async {
                        self.webRTCClient.set(remoteCandidate: candidate) { error in
                            print("Received remote candidate")
                            self.remoteCandidateCount += 1
                        }
                    }
                }



                func webRTCClient(_ client: WebRTCClient, didDiscoverLocalCandidate candidate: RTCIceCandidate) {
                    print("Discovered local candidate")
                    localCandidateCount += 1
                    signalClient.send(candidate: candidate)
                }
                
                func webRTCClient(_ client: WebRTCClient, didChangeConnectionState state: RTCIceConnectionState) {
                    let textColor: UIColor
                    print(state)
                    switch state {
                    case .connected, .completed:
                        textColor = .green
                        signalingConnected = true
                    case .disconnected:
                        textColor = .orange
                    case .failed, .closed:
                        textColor = .red
                    case .new, .checking, .count:
                        textColor = .black
                    @unknown default:
                        textColor = .black
                    }
                    DispatchQueue.main.async {
                        //self.webRTCStatus = state.description.capitalized
                        // This part might need modification in SwiftUI to reflect the status change
                        // Change the UI representation according to the connection state
                    }
                }
                
                func webRTCClient(_ client: WebRTCClient, didReceiveData data: Data) {
                    DispatchQueue.main.async {
                        let message = String(data: data, encoding: .utf8) ?? "(Binary: \(data.count) bytes)"
                        let alert = UIAlertController(title: "Message from WebRTC", message: message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        // You might need a different way to present an alert in SwiftUI
                    }
                }
                 
            }
       
}

/*#Preview {
    CallPenddingview()
}*/
