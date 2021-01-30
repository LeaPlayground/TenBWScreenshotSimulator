//
//  BWRoundCollection.swift
//  TenBWWinterHoliday
//
//  Created by Alan Richard on 1/30/21.
//

import SwiftUI
import Combine

class BWRoundCollection: ObservableObject {
    static let numberChineseMap = [1:"一", 2:"二", 3:"三", 4:"四", 5:"五", 6:"六", 7:"七", 8:"八", 9:"九", 10:"十"]
    
    private let defaultUserKey = "TenBw.User"
    
    @Published private(set) var rounds: [BWRound]

    @Published var user: UserInformation
    private var autoSaveUser: AnyCancellable?
    
    func getBadgeImage(for index: Int) -> UIImage? {
        return UIImage(named: "bg_hz\(index + 1)")
    }
    
    init() {
        self.rounds = [BWRound]()
        self.user = UserInformation(name: (UserDefaults.standard.value(forKey: self.defaultUserKey) as? String) ?? "")
        
        for index in 1...10 {
            self.rounds.append(BWRound(id: index))
        }
        
        autoSaveUser = self.$user.sink { user in
            UserDefaults.standard.set(user.name, forKey: self.defaultUserKey)
        }
    }
    
    func indexOf(turn: BWRound) -> Int {
        return self.rounds.firstIndex(where: { turn.id == $0.id })!
    }
    
    static func numberToChineseChar(_ number: Int) -> String? {
        return BWRoundCollection.numberChineseMap[number]
    }
    
    // MARK: - Intent(s)
    func changeUserName(to name: String) {
        user.name = name
    }
}
