//
//  BottomScrollForeCast.swift
//  CombinePOC
//
//  Created by Talish George on 22/07/20.
//  Copyright © 2020 1276121. All rights reserved.
//

import SwiftUI

struct BottomScrollForeCast: View {
    @ObservedObject var forecastViewModel: ForecastViewModel
    
    var body: some View {
        ZStack {
            
            ZStack(alignment: .topLeading) {
                Text(String(Helper().timeConverter(timeStamp: forecastViewModel.date, isDay: true)))
                .foregroundColor(Color("icons"))
            }.offset(y: -75)
            
        }.frame(width: 220, height: 200)
        .background(Color.white)
        .cornerRadius(30)
        .padding(.leading, 15)
    }
}
//
//struct BottomScrollForeCast_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomScrollForeCast()
//    }
//}



