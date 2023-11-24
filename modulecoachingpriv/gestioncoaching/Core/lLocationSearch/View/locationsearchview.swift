//
//  locationsearchview.swift
//  modulecoachingpriv
//
//  Created by Mac-Mini_2021 on 08/11/2023.
//

import SwiftUI

struct locationsearchview: View {
    var body: some View {
        HStack{
            Rectangle().fill(Color.black)
                .frame(width: 8,height: 8)
                .padding(.horizontal)
            Text("find your coach").foregroundColor(Color(.darkGray))
            Spacer()
        }.frame(width:UIScreen.main.bounds.width - 64,height: 50)
            .background(Rectangle()
                .fill(Color.white)
                .shadow(color:.black,radius: 6)
            )
    }
}

struct locationsearchview_Previews: PreviewProvider {
    static var previews: some View {
        locationsearchview()
    }
}
