//
//  GameButton.swift
//  SetGame
//
//  Created by Slava Rykov on 04.06.2023.
//

import SwiftUI

struct GameButton: View {
    let label: () -> Text
    let action: () -> Void
    
    init(label: @escaping () -> Text, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }
    
    var body: some View {
        Button { action() }
        label: {
            label()
                .padding(.horizontal, 70)
                .padding(.vertical, 15)
                .foregroundColor(.black)
        }
    }
}

struct GameButton_Previews: PreviewProvider {
    static var previews: some View {
        GameButton {
            Text("Game button")
        }
        action: {}
    }
}
