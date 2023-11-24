//
//  coachrequestview.swift
//  modulecoachingpriv
//
//  Created by Apple Esprit on 9/11/2023.
//

import SwiftUI

struct coachrequestview: View {
    @EnvironmentObject var viewModel : Locationsearchviewmodel

    var body: some View {
        
            VStack {
                Capsule()
                    .foregroundColor (Color(.systemGray5))
                    .frame(width: 48, height: 6)
                    .padding(5)
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 5)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                    
                }.padding(.bottom,10)
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
                Text(viewModel.selectedcoach!) .font(.custom("arial", size: 24)) .padding(.top,10)
                  //  .bold()
                Text("Coach De Vie") .font(.system(.subheadline)) .padding(.top,3)
                 //   .bold()
                NavigationLink(destination: MessagesView()) {
                    Text("Get in Touch")
                        .fontWeight(.bold)
                        .frame(width: UIScreen.main.bounds.width -
                               60, height: 50)
                        .background (Color(hex: "00b36e"))
                        .cornerRadius (20)
                        .foregroundColor(.white)
                }
                .padding( .top,10)
                
                .cornerRadius(30)
                
            }.frame(width: UIScreen.main.bounds.width -
                    25,height: 350)
            .background (Color(hex: "e6f0ec"))
            .cornerRadius (10)
            .padding(.horizontal)
        }
    
}
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0

        scanner.scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

struct coachrequestview_Previews: PreviewProvider {
    static var previews: some View {
        coachrequestview()
    }
}
