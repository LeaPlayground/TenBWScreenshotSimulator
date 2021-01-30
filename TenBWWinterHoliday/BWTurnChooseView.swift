//
//  BWTurnChooseView.swift
//  TenBWWinterHoliday
//
//  Created by Alan Richard on 1/30/21.
//

import SwiftUI


struct BWTurnChooseView: View {
    @ObservedObject var collection: BWRoundCollection
    
    //@State var hideStatusBar = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(collection.rounds) { turn in
                    NavigationLink(
                        destination:
                            BWTurnView(
                                round: turn,
                                showNextButton: (collection.indexOf(turn: turn) != collection.rounds.count - 1)
                            )
                            .environmentObject(collection)
                    ) {
                        Text("Round \(turn.id)")
                    }
//                    .onAppear {
//                        hideStatusBar = true
//                    }
//                    .onDisappear {
//                        hideStatusBar = false
//                    }
                }
            }
            .navigationTitle("BW List")
        }
        //.statusBar(hidden: true) // SwiftUI bug causes this not working
    }
}

struct BWTurnChooseView_Previews: PreviewProvider {
    static var previews: some View {
        BWTurnChooseView(collection: BWRoundCollection())
    }
}
