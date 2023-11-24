//
//  RTCVideoView.swift
//  modulecoachingpriv
//
//  Created by Farah Metoui on 16/11/2023.
//

import SwiftUI
import WebRTC

struct RTCVideoRepresentable: UIViewRepresentable {
    
   var  webRTCClient: WebRTCClient
    let isLocal: Bool // Indicates whether it's for local or remote video
    let videoView = RTCMTLVideoView()
    init(webRTCClient: WebRTCClient, isLocal: Bool) {
        self.webRTCClient = webRTCClient
      
    
        
        self.isLocal = isLocal
        
    }
    func makeUIView(context: Context) -> RTCMTLVideoView {
        
        videoView.videoContentMode = .scaleAspectFill
        
        if isLocal{
            webRTCClient.startCaptureLocalVideo(renderer: videoView)
        }else{
            
            webRTCClient.renderRemoteVideo(to: videoView)
        }
        
        return videoView
    }

    func updateUIView(_ uiView: RTCMTLVideoView, context: Context) {
        if isLocal{
            webRTCClient.startCaptureLocalVideo(renderer: uiView)
        }else{
            
            webRTCClient.renderRemoteVideo(to: uiView)
        }
        
    }
    private func embedView(_ view: UIView, into containerView: UIView) {
        containerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["view":view]))
        
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                    options: [],
                                                                    metrics: nil,
                                                                    views: ["view":view]))
        containerView.layoutIfNeeded()
    }
}
