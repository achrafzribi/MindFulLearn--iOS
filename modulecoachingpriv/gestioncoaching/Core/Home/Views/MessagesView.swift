//
//  MEssagesView.swift
//  modulecoachingpriv
//
//  Created by Apple Esprit on 9/11/2023.
//

import SwiftUI
import WebRTC
struct MessagesView: View {
    
    //@State var messages = [Messages]()
    @State var chatText = ""
   @ObservedObject var messageviewmodel = Messagesviewmodel()
    @EnvironmentObject var user : Userviewmodel
    var body: some View {
        NavigationView{
            ZStack {
                
                messagesView
                VStack(spacing: 0) {
                    
                    Spacer()
                    chatBottomBar
                        .background(Color.white.ignoresSafeArea())
                }
            }.onAppear{
                messageviewmodel.establishConnection(userid: user.user!.__id!)
                messageviewmodel.connectionestablished(userid: user.user!.__id!)
            }
        }
        
    }
    
    private var messagesView: some View {
       
        ZStack{
            VStack{
                TopBar()
                
                ScrollView {
                    ForEach(messageviewmodel.messages, id: \.self) { mes in
                        if mes.sender == user.user!.__id! {
                        HStack {
                            Spacer()
                            HStack {
                                Text(mes.content)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color(hex: "27b040"))
                            .cornerRadius(25)
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    } else {
                        HStack {
                            HStack {
                                Text(mes.content)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(25)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }

                    }
                    
                    HStack{ Spacer() }
                        .frame(height: 50)
                }.padding(.top,5)
                
            }.background(Color(hex: "e6f0ec"))
        }
    }
    
    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundColor(Color(.darkGray))
            ZStack {
                
                TextField("Enter a Message", text: $chatText)
                    .padding()
                    .background(Color(hex: "ceded8"))
                    .cornerRadius(50)
                
            }
            .frame(height: 40)
            .cornerRadius(6)
            
            Button {
                let message = Messages(id: 1, sender: user.user!.__id!, recipient: "user1", content: chatText)
               // messageviewmodel.messages.append(message)
                messageviewmodel.sendMessage(senderID: user.user!.__id!, receiverID: user.user!.__id!, message: chatText)
                chatText = ""
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(hex: "00b36e"))
            .cornerRadius(25)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(hex: "e6f0ec"))
    }
   

    private struct TopBar: View {
        @State private var isShowingFloatingcallingView = false
        var  webRTCClient = WebRTCClient(iceServers: Config.default.webRTCIceServers)
      var signalClient = SignalingClient(webSocket: NativeWebSocket(url: Config.default.signalingServerUrl))
        @StateObject var videoLogic : Videologic
        
        init() {
            signalClient.connect()

            let logic = Videologic(webRTCClient: webRTCClient, signalClient: signalClient)
                _videoLogic = StateObject(wrappedValue: logic)

                // Fetch the environment objects
               
            }
        var body: some View {
            
            
            
            HStack {
                Circle()
                    .fill(Color(hex: "00b36e")) // Circle color
                    .frame(width: 50, height: 50) // Circle size
                    .overlay(
                        Image("coach2") // Replace with your image name
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45) // Image size
                            .clipShape(Circle())
                            .padding(10) // Padding between the image and the circle
                    )
                    .padding()
                Text("Iheb Debbech")
                    .foregroundColor(Color(.gray))
                    .font(.system(size: 17))
                    .padding(.leading, 5)
                    .padding(.top, -4)
                Spacer()
                Button(action: {
                    // Add action for the call button
                    print("Call button tapped")
                }) {
                    Image(systemName: "phone.fill")
                        .font(.title) // Adjust the font size if needed
                        .foregroundColor(Color(hex: "27b040")) // Set the color of the icon
                }
                // Add padding to the button
                
                Button(action: {
                    webRTCClient.offer { (sdp) in
                       videoLogic.hasLocalSdp = true
                        
                            self.signalClient.send(sdp: sdp)
                        
                   }
                    // Add action for the video button
                    isShowingFloatingcallingView=true
                }) {
                    Image(systemName: "video.fill")
                        .font(.title) // Adjust the font size if needed
                        .foregroundColor(Color(hex: "075c29"))
                    .padding(25)                         }
                            }.frame(height: 30)
                .sheet(isPresented: $videoLogic.hasRemoteSdp, content: {
                    CallPenddingview(webRTCClient: webRTCClient, signalClient: signalClient).transition(.move(edge: .bottom)).background(Color.black.opacity(0.3))
                })
                    .popover(isPresented: $isShowingFloatingcallingView, arrowEdge: .leading, content: {videocallview(webRTCClient: webRTCClient,signalClient: signalClient).transition(.move(edge: .bottom)).background(Color.black.opacity(0.3))                   })

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
    private var newMessageButton: some View {
        Button {
            
        } label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 15)
        }
    }
}
struct MEssagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
