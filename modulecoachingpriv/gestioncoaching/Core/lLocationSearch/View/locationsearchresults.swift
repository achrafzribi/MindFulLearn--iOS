//
//  locationsearchresults.swift
//  modulecoachingpriv
//
//  Created by Mac-Mini_2021 on 08/11/2023.
//

import SwiftUI

struct locationsearchresults: View {
    let title: String
    let subtitle :String
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40,height: 40)
            VStack(alignment: .leading,spacing: 4){
                Text(title)
                    .font(.body)
                Text(subtitle)
                    .font(.system(size:15))
                    .foregroundColor(.gray)
                Divider()
            }.padding(.leading)
        }.padding(.leading)
    }
}

struct locationsearchresults_Previews: PreviewProvider {
    static var previews: some View {
        locationsearchresults(title: "starbucks", subtitle: "123 main St")
    }
}
