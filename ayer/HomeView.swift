//
//  HomeView.swift
//  ayer
//
//  Created by Ezaden Seraj on 29/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import SwiftUI



struct WeatherDetails: View {
    
    var weather: Weather

    let viviColor = Color(red: 168/255, green: 162/255, blue: 255/255)
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("\(weather.temperature)")
                .foregroundColor(.white)
                .font(.system(size: 100))
                .fontWeight(.bold)
            
            Text("\(weather.label)")
                .foregroundColor(.white)
                .font(.title)
            
            Text("Humidity")
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
            
            Text("\(weather.humidity)")
                .foregroundColor(viviColor)
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

struct TodaysWeatherCard: View {
    
    var weather: Weather

    var body: some View {
        VStack {
            Image("cloud_sun")
                .overlay(
                    Image("cloud")
                        .frame(width:135, height:115),
                  alignment: .bottomTrailing
                )
                .overlay(
                    WeatherDetails(weather: weather),
                    alignment: .center
                )
        }
    }
}


struct NextDaysCard: View {
    
    let weather: Weather
    
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var body: some View {
        VStack {
            Text("\(days.randomElement()!)")
                .foregroundColor(.white)
                .font(.title)
            
            Image("icon_sun")
            
            Text("\(weather.humidity)")
                .foregroundColor(.white)
                .font(.title)
        }
    }
}


struct NextDaysView: View {
    //change this
  let days: String
  let color: UIColor
    let weather: Weather
    
  var body: some View {

    Color(color)
          .frame(width: 160, height: 200)
          .border(Color.gray.opacity(0.5), width: 0.5)
          .cornerRadius(30)
        .overlay(
            NextDaysCard(weather: weather),
            alignment: .center
        )
   }
}


struct CustomColors {
    static let mixedGreen = UIColor.init(netHex: 0x28E0AE)
    static let pink = UIColor.init(netHex: 0xFF0090)
    static let yellow = UIColor.init(netHex: 0xFFAE00)
    static let sky = UIColor.init(netHex: 0x0090FF)
    static let red = UIColor.init(netHex: 0xDC0000)
    static let darkBlue = UIColor.init(netHex: 0x0051FF)
}


struct HomeView: View {
    
    @State private var selectedCategory = 0
    
    let weather = Weather()
    
    
    let categories = ["Today", "Tomorrow", "Next Week"]
    
    let arrayOfColors = [CustomColors.mixedGreen, CustomColors.pink, CustomColors.yellow, CustomColors.sky, CustomColors.red, CustomColors.darkBlue]

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Picker("Categories", selection: $selectedCategory) {
                ForEach(0..<categories.count) {
                    Text("\(self.categories[$0])")
                }
            }.pickerStyle(SegmentedPickerStyle())
            .background(Color.white)
            
            
            TodaysWeatherCard(weather: weather)
            
            Spacer()
            
            Text("Next 15 Days")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 19/255, green: 14/255, blue: 81/255))
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(0..<15) {_ in
                        NextDaysView(days: "", color: self.arrayOfColors.randomElement()!, weather: self.weather)
                    }
                }
                .padding(.leading, 10)
            }
            .frame(height: 190)
            
            Spacer()
                
        }
        .navigationBarTitle("City", displayMode: .inline)
        .navigationBarItems(trailing:
            Image(systemName: SFSymbolName.magnifyingGlass)
        )
        .navigationBarBackButtonHidden(true)
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct Weather {
    let temperature = "25°"
    let label = "Clouds & sun"
    let humidity = "35°"
}

