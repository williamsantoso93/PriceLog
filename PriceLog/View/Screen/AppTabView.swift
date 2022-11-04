//
//  AppTabView.swift
//  PriceLog
//
//  Created by William Santoso on 04/11/22.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            AllProductScreen()
                .tabItem {
                    Label("Product", systemImage: "bag")
                }
            CategoryScreen()
                .tabItem {
                    Label("Category", systemImage: "tag")
                }
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
