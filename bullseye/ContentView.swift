//
//  ContentView.swift
//  bullseye
//
//  Created by Hong-Gyu Lee on 3/5/20.
//  Copyright © 2020 Hong-Gyu Lee. All rights reserved.
//
import SwiftUI


extension Color {
	static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}

struct LabelStyle: ViewModifier {
	func body(content: Content) -> some View {
		return content
			.foregroundColor(Color.white)
			.modifier(Shadow())
			.font(Font.custom("Arial Rounded MT Bold", size: 18))
	}
}

struct ValueStyle: ViewModifier {
	func body(content: Content) -> some View {
		return content
			.foregroundColor(Color.yellow)
			.modifier(Shadow())
			.font(Font.custom("Arial Rounded MT Bold", size: 24))
	}
}

struct ButtonLargeTextStyle: ViewModifier {
	func body(content: Content) -> some View {
		return content
			.foregroundColor(Color.black)
			.font(Font.custom("Arial Rounded MT Bold", size: 18))
	}
}


struct ButtonSmallTextStyle: ViewModifier {
	func body(content: Content) -> some View {
		return content
			.foregroundColor(Color.black)
			.font(Font.custom("Arial Rounded MT Bold", size: 12))
	}
}

struct Shadow: ViewModifier {
	func body(content: Content) -> some View {
		return content
			.shadow(color: Color.black, radius: 5, x: 2, y: 2)
	}
}


struct ContentView: View {
	@State var alertIsVisible = false
	@State var sliderValue = 50.0
	@State var target = Int.random(in:1...100)
	@State var round_number = 1
	@State var current_score = 0
	let midnightBlue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0)
	
	
	var body: some View {
		VStack {
			Spacer()
			
			// target row
			HStack {
				Text("dickless for michael chiklis:").modifier(LabelStyle())
				Text("\(target)").modifier(ValueStyle())
			}
			Spacer()
			
			// slider row
			HStack {
				Text("1").modifier(LabelStyle())
				Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
				Text("100").modifier(LabelStyle())
			}
			Spacer()
			
			// hit me row
			Button(action: {
				self.alertIsVisible = true
			}) {
				Text(/*@START_MENU_TOKEN@*/"hit me"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
			}
			.alert(isPresented: $alertIsVisible) { () -> Alert in
				let points = pointsForCurrentRound()
				let title = generateAlertTitle()
				let announcement = "Slider value: \(sliderValueRounded()).\n" + "You scored \(points) points."
				return Alert(title: Text(title), message: Text(announcement), dismissButton: .default(Text("BYE")) {
					self.current_score += points
					self.target = Int.random(in:1...100)
					self.round_number += 1
					})
			}
			.background(Image("Button")).modifier(Shadow())
			Spacer()
			
			// game info row
			HStack {
				Button(action: {
					self.startNewGame()
				}) {
					HStack {
						Image("StartOverIcon")
						Text("start over").modifier(ButtonSmallTextStyle())
					}
				}
				.background(Image("Button")).modifier(Shadow())
				Spacer()
				Text("score:").modifier(LabelStyle())
				Text("\(current_score)").modifier(ValueStyle())
				Spacer()
				Text("round:").modifier(LabelStyle())
				Text("\(round_number)").modifier(ValueStyle())
				Spacer()
				NavigationLink(destination: AboutView()) {
					HStack {
						Image("InfoIcon")
						Text("info").modifier(ButtonSmallTextStyle())
					}
				}
				.background(Image("Button")).modifier(Shadow())
			}
			.padding(.bottom, 20)
		}
		.background(Image("Background"), alignment: .center)
		.accentColor(midnightBlue)
		.navigationBarTitle("bullseye")
	}
	
	
	func sliderValueRounded() -> Int {
		Int(sliderValue.rounded())
	}
	
	func amountOff() -> Int {
		abs(sliderValueRounded() - target)
	}
	
	func pointsForCurrentRound() -> Int {
		let difference = amountOff()
		var points = 100 - amountOff()
		if difference == 0 {
			points += 100
		} else if difference == 1 {
			points += 50
		}
		
		return points
	}
	
	func generateAlertTitle() -> String {
		let difference = amountOff()
		let title: String
		if difference == 0 {
			title = "Perfect"
		} else if difference <= 5 {
			title = "Almost"
		} else if difference <= 10 {
			title = "Not Bad"
		} else {
			title = "u dumb"
		}
		
		return title
	}
	
	func startNewGame() {
		round_number = 1
		current_score = 0
		target = Int.random(in:1...100)
		sliderValue = 50.0
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.previewLayout(.fixed(width: 896, height: 414))
	}
}

