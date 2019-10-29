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
    
    let icons = ["icon_sun", "icon_cloud", "icon_rain", "icon_wind"]

    let viviColor = Color(red: 237/255, green: 240/255, blue: 245/255)
    
    var body: some View {
        VStack {
            Text("\(days.randomElement()!)")
                .foregroundColor(.white)
                .font(.title)
            
            Image(icons.randomElement()!)
                .frame(height:50)
            
            Text("\(weather.humidity)")
                .foregroundColor(.white)
                .font(.title)
            
            HStack(spacing: 30) {
                Text("\(weather.humidity)")
                    .foregroundColor(viviColor)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                Text("\(weather.humidity)")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
            }
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
          .frame(width: 160, height: 220)
          .border(Color.gray.opacity(0.5), width: 0.5)
          .cornerRadius(30)
        .overlay(
            NextDaysCard(weather: weather),
            alignment: .center
        )
        .shadow(color: Color.gray.opacity(0.8), radius: 5, x: 0, y: 5)
    
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
    
//    red: 93/255, green: 80/255, blue: 254/255)
    let categories = ["Today", "Tomorrow", "Next Week"]
    
    let arrayOfColors = [CustomColors.mixedGreen, CustomColors.pink, CustomColors.yellow, CustomColors.sky, CustomColors.red, CustomColors.darkBlue]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer()
            Picker("Categories", selection: $selectedCategory) {
                ForEach(0..<categories.count) {
                    Text("\(self.categories[$0])")
                }
            }.pickerStyle(SegmentedPickerStyle())
                .background(Color.white)
                .cornerRadius(20)
        
            TodaysWeatherCard(weather: weather)
                .padding(.leading, 20)
            
            Spacer()
            
            Text("Next 15 Days")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 19/255, green: 14/255, blue: 81/255))
                .padding(.leading, 20)
                .padding(.bottom, 20)
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(0..<15) {_ in
                        NextDaysView(days: "", color: self.arrayOfColors.randomElement()!, weather: self.weather)
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
            
                Spacer(minLength: 20)
            }
            .frame(height: 190)
            
            Spacer()
                
        }
        .navigationBarTitle("Kuala Lumpur, Malaysia", displayMode: .inline)
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

