//
//  HomeView.swift
//  ayer
//
//  Created by Ezaden Seraj on 29/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import SwiftUI



struct WeatherDetails: View {
    
    var weatherData: HomeViewModel

    let viviColor = Color(red: 168/255, green: 162/255, blue: 255/255)
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("\(weatherData.temperature)")
                .foregroundColor(.white)
                .font(.system(size: 100))
                .fontWeight(.bold)
            
            Text("\(weatherData.description)")
                .foregroundColor(.white)
                .font(.title)
            
            Text("Humidity")
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
            
            Text("\(weatherData.humidity)")
                .foregroundColor(viviColor)
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

struct TodaysWeatherCard: View {
    
    var weatherData: HomeViewModel

    var body: some View {
        VStack {
            Image("cloud_sun")
                .overlay(
                    Image("cloud")
                        .frame(width:135, height:115),
                  alignment: .bottomTrailing
                )
                .overlay(
                    WeatherDetails(weatherData: weatherData),
                    alignment: .center
                )
        }
    }
}


struct IconView: View {
    @ObservedObject var iconViewModel: IconViewModel
    
    init(iconName: String) {
        iconViewModel = IconViewModel(iconName: iconName)
    }
    
    var body: some View {
        Image(uiImage: (((iconViewModel.data.isEmpty) ? UIImage(named: "icon_sun") : UIImage(data:iconViewModel.data))!))
    }
}

struct NextDaysCard: View {
    
    let dailyWeather: DailyWeatherViewModel
    
    @State var iconName = ""
    
    
    let icons = ["icon_sun", "icon_cloud", "icon_rain", "icon_wind"]
    
    let viviColor = Color(red: 187/255, green: 192/255, blue: 212/255)
    
    var body: some View {

        VStack {
            Text("\(dailyWeather.day)")
                .foregroundColor(.white)
                .font(.title)
            
            Text("\(dailyWeather.date)")
                .foregroundColor(.white)
                .font(.footnote)
            
            IconView(iconName: dailyWeather.icon)
            
            Text("\(dailyWeather.temperature)")
                .foregroundColor(.white)
                .font(.title)
            
            HStack(spacing: 30) {
                VStack {
                    Text("Min")
                        .foregroundColor(.white)
                        .font(.footnote)
                    Text("\(dailyWeather.minTemperature)")
                        .foregroundColor(viviColor)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                }
                VStack {
                    Text("Max")
                        .foregroundColor(.white)
                        .font(.footnote)
                    Text("\(dailyWeather.maxTemperature)")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                }
            }
        }.onAppear(perform: {
            self.iconName = self.dailyWeather.icon
        })
    }
}


struct NextDaysView: View {
  let color: UIColor
  let dailyWeather: DailyWeatherViewModel
    
  var body: some View {

    Color(color)
          .frame(width: 160, height: 220)
          .border(Color.gray.opacity(0.5), width: 0.5)
          .cornerRadius(30)
        .overlay(
            NextDaysCard(dailyWeather: dailyWeather),
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
    @State private var cityName = ""
    
    @ObservedObject var homeViewModel = HomeViewModel()
    @ObservedObject var weeklyWeatherViewModel = WeeklyWeatherViewModel()


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
        
            TodaysWeatherCard(weatherData: homeViewModel)
                .padding(.leading, 20)
            
            Spacer()
            
            Text("Next 5 Days")
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 19/255, green: 14/255, blue: 81/255))
                .padding(.leading, 20)
                .padding(.bottom, 20)
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(weeklyWeatherViewModel.dataSource) { dailyWeather in
                        NextDaysView(color: self.arrayOfColors.randomElement()!, dailyWeather: dailyWeather)
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
            
                Spacer(minLength: 20)
            }
            .frame(height: 190)
            
            Spacer()
                
        }
        .navigationBarTitle(cityName)
        .onAppear(perform: SetNavBarTitle)
        .navigationBarItems(trailing:
            Image(systemName: SFSymbolName.magnifyingGlass)
        )
        .navigationBarItems(trailing:
            Button(action: {
                
//                print("TESTING:\(self.weeklyWeatherViewModel)")
//                self.homeViewModel.fetchWeatherData()
            }, label: {
                Text("TEST")
            })
        )
        .navigationBarBackButtonHidden(true)
    }
    
    func SetNavBarTitle() {
        cityName = homeViewModel.name
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

