//
//  VideoView.swift
//  modulecoachingpriv
//
//  Created by Farah Metoui on 16/11/2023.
//

import SwiftUI
import WebRTC

struct VideoView: View {
   
   
    
    var  webRTCClient = WebRTCClient(iceServers: Config.default.webRTCIceServers)
  var signalClient = SignalingClient(webSocket: NativeWebSocket(url: Config.default.signalingServerUrl))
    @StateObject var videoLogic : Videologic
    
    init() {
        let logic = Videologic(webRTCClient: webRTCClient, signalClient: signalClient)
            _videoLogic = StateObject(wrappedValue: logic)

            // Fetch the environment objects
           
        }
     
           
        
    var body: some View {
        NavigationView{
            VStack {
                Text(videoLogic.signalingConnected ? "Connected" : "Not connected")
                    .foregroundColor(videoLogic.signalingConnected ? .green : .red)
                    .padding()
                
                // Other UI components like labels, buttons, etc.
                
                Button(action: {
                    offerDidTap()
                }) {
                    Text("Offer")
                }
                
                Button(action: {
                    answerDidTap()
                }) {
                    Text("Answer")
                }
                
                Button(action: {
                    speakerDidTap()
                }) {
                    Text(videoLogic.speakerOn ? "Speaker Off" : "Speaker On")
                }
                
                NavigationLink(destination: videocallview(webRTCClient: webRTCClient,signalClient: signalClient)
                ) {
                    
                    Text("Present Video")
                }
                
                Button(action: {
                    muteDidTap()
                }) {
                    Text(videoLogic.mute ? "Unmute" : "Mute")
                }
                
                Spacer()
            }.onAppear {
                // Connect to signaling when the view appears
                self.signalClient.connect()
            }
            .padding()
        }
    }
        
    func offerDidTap() {
        self.webRTCClient.offer { (sdp) in
           videoLogic.hasLocalSdp = true
            
                self.signalClient.send(sdp: sdp)
            
       }
   }
   
    func answerDidTap() {
        self.webRTCClient.answer { (localSdp) in
         
                videoLogic.hasLocalSdp = true
                self.signalClient.send(sdp: localSdp)
            
       }
   }
   
    func speakerDidTap() {
        if videoLogic.speakerOn {
           webRTCClient.speakerOff()
       } else {
           webRTCClient.speakerOn()
       }
        videoLogic.speakerOn.toggle()
   }
   
    func videoDidTap() {
       
       // Implement your logic for presenting video
   }
   
    func muteDidTap() {
        videoLogic.mute.toggle()
        if videoLogic.mute {
           webRTCClient.muteAudio()
       } else {
           webRTCClient.unmuteAudio()
       }
   }
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
