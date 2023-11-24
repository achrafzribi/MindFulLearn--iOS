//
//  MapfullView.swift
//  modulecoachingpriv
//
//  Created by Mac-Mini_2021 on 07/11/2023.
//

import SwiftUI

struct MapfullView: View {
        @State private var mapState = mapviewstate.noInput
    @State private var Coachloc = false
        var body: some View {
            NavigationView {
            ZStack(alignment: .bottom){
                ZStack(alignment: .top){
                    
                    
                    mapviewrepresentable(mapstate: $mapState,coachloc : $Coachloc).ignoresSafeArea()
                    
                    if mapState == .noInput {
                        locationsearchview().padding(.top,72).onTapGesture {
                            withAnimation(.spring()){
                                mapState = .searchingForLocation
                            }
                        }
                        
                    }else if mapState == .searchingForLocation{
                        Locationsearchspaceview(mapstate: $mapState).onTapGesture {
                            mapState = .searchingForLocation
                        }
                    }
                  
                    Mapviewactionbutton(mapstate: $mapState)
                        .padding(.leading)
                        .padding(.top,4)
                    Button("get location"){
                        Coachloc.toggle()
                    }
                }
                if mapState == .locationSelected || mapState == .displaycoachview{
                    coachrequestview().transition(.move(edge: .bottom))
                }
            }.edgesIgnoringSafeArea(.bottom)
        }

    }
}

struct MapfullView_Previews: PreviewProvider {
    static var previews: some View {
        MapfullView()
    }
}
