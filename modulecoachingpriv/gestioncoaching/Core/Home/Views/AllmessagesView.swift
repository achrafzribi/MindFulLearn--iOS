//
//  AllmessagesView.swift
//  modulecoachingpriv
//
//  Created by Apple Esprit on 9/11/2023.
//

import SwiftUI

struct AllmessagesView: View {

        @State var shouldShowLogOutOptions = false
        
        private var customNavBar: some View {
            HStack(spacing: 16) {
                
                Circle()
            .fill(Color(hex: "00b36e")) // Circle color
                    .frame(width: 75, height: 75) // Circle size
                    .overlay(
                        Image("coach2") // Replace with your image name
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70) // Image size
                            .clipShape(Circle())
                            .padding(10) // Padding between the image and the circle
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("USERNAME")
                        .font(.system(size: 24, weight: .bold))
                    
                    HStack {
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 14, height: 14)
                        Text("online")
                            .font(.system(size: 12))
                            .foregroundColor(Color(.lightGray))
                    }
                    
                }
                
                Spacer()
                Button {
                    shouldShowLogOutOptions.toggle()
                } label: {
                    Image(systemName: "gear")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(.label))
                }
            }
            .padding()
            .actionSheet(isPresented: $shouldShowLogOutOptions) {
                .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                    .destructive(Text("Sign Out"), action: {
                        print("handle sign out")
                    }),
                        .cancel()
                ])
            }
        }
        
        var body: some View {
            NavigationView {
                
                VStack {
                    customNavBar
                    messagesView
                }.background(Color(hex: "e6f0ec"))
                .overlay(
                    newMessageButton, alignment: .bottom)
                .navigationBarHidden(true)
            }
        }
        
        private var messagesView: some View {
            ScrollView {
                ForEach(0..<10, id: \.self) { num in
                    VStack {
                        HStack(spacing: 16) {
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
                             
                            
                            
                            VStack(alignment: .leading) {
                                Text("Username")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(Color(hex: "075c29"))
                                    .padding(.bottom,3)
                                
                                Text("Message sent to user")
                                    .font(.system(size: 14,weight: .bold))
                                    .foregroundColor(Color(.gray))
                            }
                            Spacer()
                            
                            Text("22d")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        Divider()
                            .padding(.vertical, 8)
                    }.padding(.horizontal)
                    
                }.padding(.bottom, 50)
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
                .background (Color(hex: "00b36e"))
                    .cornerRadius(32)
                    .padding(.horizontal)
                    .shadow(radius: 15)
            }
        }
    
}

struct AllmessagesView_Previews: PreviewProvider {
    static var previews: some View {
        AllmessagesView()
    }
}
