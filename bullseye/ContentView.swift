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
			.foregroundColor(.gray)
			.font(Font.custom("Arial Rounded MT Bold", size: 18))
	}
}

struct ValueStyle: ViewModifier {
	func body(content: Content) -> some View {
		return content
			.foregroundColor(Color.blue)
			.font(Font.custom("Arial Rounded MT Bold", size: 24))
	}
}

struct ButtonLargeTextStyle: ViewModifier {
	func body(content: Content) -> some View {
		return content
			.foregroundColor(.gray)
			.font(Font.custom("Arial Rounded MT Bold", size: 18))
	}
}


struct ButtonSmallTextStyle: ViewModifier {
	func body(content: Content) -> some View {
		return content
			.foregroundColor(.gray)
			.font(Font.custom("Arial Rounded MT Bold", size: 12))
	}
}


struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
					.padding(30)
					.background(
						Group {
								if configuration.isPressed {
										Circle()
												.fill(Color.offWhite)
												.overlay(
														Circle()
																.stroke(Color.gray, lineWidth: 4)
																.blur(radius: 4)
																.offset(x: 2, y: 2)
																.mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
												)
												.overlay(
														Circle()
																.stroke(Color.white, lineWidth: 8)
																.blur(radius: 4)
																.offset(x: -2, y: -2)
																.mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
												)
								} else {
										Circle()
												.fill(Color.offWhite)
												.shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
												.shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
								}
						}
					)
    }
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
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
		ZStack {
			Color.offWhite
			VStack {
				Spacer()
				
				// target row
				ZStack {
					HStack {
							Text("dickless for michael chiklis:").modifier(LabelStyle())
							Text("\(target)").modifier(ValueStyle())
					}
				}
				Spacer()
				
				// slider row
				HStack {
					Spacer()
					Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
						.buttonStyle(SimpleButtonStyle())
					Spacer()
				}
				Spacer()
				
				// hit me row
				Button(action: {
					self.alertIsVisible = true
				}) {
					Text("hit me").modifier(ButtonLargeTextStyle())
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
				.buttonStyle(SimpleButtonStyle())
				
				Spacer()
				
				// game info row
				HStack {
					Button(action: {
						self.startNewGame()
					}) {
						HStack {
							Image("StartOverIcon")
						}
					}
					.buttonStyle(SimpleButtonStyle())
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
						}
					}
				.buttonStyle(SimpleButtonStyle())
				}
				.padding(.bottom, 30)
				.padding(.leading, 30)
				.padding(.trailing, 30)
			}
			.accentColor(.gray)
			.navigationBarHidden(true)
			.navigationBarTitle(Text("Home"))
		}
		.edgesIgnoringSafeArea(.all)
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

