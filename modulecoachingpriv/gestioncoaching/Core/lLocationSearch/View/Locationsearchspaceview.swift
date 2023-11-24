//
//  locationsearchview.swift
//  modulecoachingpriv
//
//  Created by Mac-Mini_2021 on 08/11/2023.
//

import SwiftUI

struct Locationsearchspaceview: View {
    @EnvironmentObject var viewModel : Locationsearchviewmodel
    @State private var startLocationText = ""
    @Binding var mapstate :mapviewstate
    var body: some View {
        VStack {
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6,height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1,height: 24)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6,height:6)
                    
                }
                TextField("Current location", text:$viewModel.queryFragment)
                    .frame (height: 32)
                    .background (Color(
                        .systemGroupedBackground))
                    .padding(.trailing)
                    
            }.padding(.horizontal)
                .padding(.top,64)
            Divider()
                .padding(.vertical)
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(viewModel.resultcoachs,id:\.self){
                        result in
                        locationsearchresults(title:result,subtitle: result).onTapGesture {
                            withAnimation(.spring()){
                                viewModel.selectLocationcoach(result)
                                mapstate = .locationSelected
                                
                            }
                            
                        }
                    }
                    ForEach(viewModel.results,id:\.self){
                        result in
                        locationsearchresults(title:result.title,subtitle: result.subtitle).onTapGesture {
                            withAnimation(.spring()){
                                viewModel.selectLocation(result)
                                mapstate = .locationSelected}
                            
                        }
                    }
                }
            }
        }.background(.white)
        
    }
    
}

struct Locationsearchspaceview_Previews: PreviewProvider {
    static var previews: some View {
        Locationsearchspaceview(mapstate:  .constant(.searchingForLocation))
    }
}
