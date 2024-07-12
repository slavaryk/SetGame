//
//  HomeScreen.swift
//  SetGame
//
//  Created by Slava Rykov on 21.06.2024.
//

import SwiftUI

struct HomeScreen: View {
	private let menuItems: [MenuItem] = [
		MenuItem(destination: .Continue),
		MenuItem(destination: .NewGame),
		MenuItem(destination: .MaxScore),
		MenuItem(destination: .History),
	]

	var body: some View {
		NavigationStack {
			List {
				ForEach(menuItems) { item in
					NavigationLink(value: item) {
						Text(item.labelText)
					}
				}
			}
			.listStyle(.plain)
			.navigationTitle("Set Game")
			.navigationDestination(for: MenuItem.self) { item in
				switch item.destination {
				case .Continue: Game(isContinue: true)
				case .NewGame: Game(isContinue: false)
				case .MaxScore: Text("Max score here")
				case .History: Text("This is history")
				}
			}
		}
	}
}

struct MenuItem: Identifiable, Hashable {
	enum Destination: String {
		case Continue = "Continue"
		case NewGame = "New Game"
		case MaxScore = "Max Score"
		case History = "History"
	}

	let destination: Destination

	var labelText: String {
		destination.rawValue
	}

	var id: Destination {
		destination.self
	}
}

struct HomeScreen_Previews: PreviewProvider {
	static var previews: some View {
		HomeScreen()
	}
}
