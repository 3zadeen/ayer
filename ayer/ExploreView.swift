//
//  ContentView.swift
//  ayer
//
//  Created by Ezaden Seraj on 28/10/2019.
//  Copyright © 2019 Ezaden Seraj. All rights reserved.
//

import SwiftUI

struct ExploreView: View {

    let lightBlue = Color(red: 154/255, green: 123/255, blue: 255/255)
    let darkBlue = Color(red: 92/255, green: 42/255, blue: 255/255)
    let black = Color(red: 19/255, green: 14/255, blue: 81/255)
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("icon_city")
                    .padding(.top)
                ZStack(alignment: .bottom) {
                    Button("Explore") {
                        
                    }
                    .padding(50)
                    .foregroundColor(black)
                    .background(Color(.white))
                    .frame(width: 190, height: 50, alignment: .center)
                    .font(.title)
                    .cornerRadius(25)
                    .offset(x: 0, y: -100)
                }
            }
            .background(LinearGradient(gradient: .init(colors: [lightBlue, darkBlue]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
