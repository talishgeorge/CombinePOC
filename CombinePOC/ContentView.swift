//
//  ContentView.swift
//  WeatherForecast
//
//  Created by 1276121 on 13/12/2019.
//  Copyright © 2019 1276121. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var forcastViewModel: ForecastViewModel
    @State var showAlert = false
    @State var showView = false
    init() {
        self.forcastViewModel = ForecastViewModel()
    }
    var body: some View {
        ZStack {
            BackSplash()
            VStack {
//                TextField("Enter City Name", text: self.$forcastViewModel.cityName) {
//                    self.forcastViewModel.searchCity()
//                }
                TopView(showField: self.showView, forcastViewModel: self.forcastViewModel)
                MidView(forcastViewModel: self.forcastViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
