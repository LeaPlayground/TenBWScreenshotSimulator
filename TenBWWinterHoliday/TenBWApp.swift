//
//  TenBWApp.swift
//  TenBWWinterHoliday
//
//  Created by Alan Richard on 1/30/21.
//

import SwiftUI

@main
struct TenBWApp: App {
    var body: some Scene {
        WindowGroup {
            BWTurnChooseView(collection: BWRoundCollection())
                .statusBar(hidden: true)
        }
    }
}
