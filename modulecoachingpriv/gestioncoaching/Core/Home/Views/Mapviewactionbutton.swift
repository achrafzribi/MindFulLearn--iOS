//
//  Mapviewactionbutton.swift
//  modulecoachingpriv
//
//  Created by Mac-Mini_2021 on 08/11/2023.
//

import SwiftUI

struct Mapviewactionbutton: View {
    @EnvironmentObject var viewModel : Locationsearchviewmodel
    @Binding var mapstate :mapviewstate
    @State private var navigateTomessages = false
    var body: some View {
        NavigationLink(destination: AllmessagesView(),isActive: $navigateTomessages){
            EmptyView()
        }
        .hidden()
        Button{
            withAnimation(.spring()){
 actionForState(state: mapstate)
                
            }

            
            
        }label: {
            
            Image(systemName: imageNameForState(state: mapstate)) 
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color:.black,radius: 6)
        }.frame(maxWidth: .infinity,alignment: .leading)
    }
    func actionForState ( state: mapviewstate) {
        switch state {
        case .noInput:
          
            navigateTomessages = true
            
            
        case .searchingForLocation:
            viewModel.selectedLocationCoordinate = nil
            mapstate = .noInput
        case .locationSelected:
          
            mapstate = .noInput
        case .displaycoachview:
            mapstate = .noInput
        }
    }
    func imageNameForState ( state: mapviewstate) -> String {
        switch state {
        case .noInput:
          
            return "message"
        case .searchingForLocation, .locationSelected,.displaycoachview:
            return "arrow.left"
      
        }
    }


}

struct Mapviewactionbutton_Previews: PreviewProvider {
    static var previews: some View {
        Mapviewactionbutton(mapstate: .constant(.noInput))
    }
}
