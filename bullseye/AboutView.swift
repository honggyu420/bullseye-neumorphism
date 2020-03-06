//
//  AboutView.swift
//  bullseye
//
//  Created by Hong-Gyu Lee on 3/5/20.
//  Copyright © 2020 Hong-Gyu Lee. All rights reserved.
//

import SwiftUI


struct AboutLabelStyle: ViewModifier {
	func body(content: Content) -> some View {
		return content
			.padding(.bottom, 20)
			.foregroundColor(Color.black)
			.lineLimit(nil)
			.multilineTextAlignment(.center)
	}
}

struct HeaderLabelStyle: ViewModifier {
	func body(content: Content) -> some View {
		return content
			.font(Font.custom("Arial Rounded MT Bold", size: 30))
			.padding(.top, 20)
			.modifier(AboutLabelStyle())
	}
}

struct BodyLabelStyle: ViewModifier {
	func body(content: Content) -> some View {
		return content
			.font(Font.custom("Arial Rounded MT Bold", size: 16))
			.padding(.leading, 60)
			.padding(.trailing, 60)
			.modifier(AboutLabelStyle())
	}
}

struct AboutView: View {
	let bgColor = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
	
	var body: some View {
		Group {
			VStack {
				Text("🎯 Bullseye 🎯")
					.modifier(HeaderLabelStyle())
				Text("This is a fun game believe me dawg")
					.modifier(BodyLabelStyle())
				Text("I swear to god it is please pay me a bunch of money for this it'll be worth it I promise I won't let you down ok")
				.modifier(BodyLabelStyle())
			}
			.background(bgColor)
		}
	.background(Image("Background"))
	}
}

struct AboutView_Previews: PreviewProvider {
	static var previews: some View {
		AboutView()
			.previewLayout(.fixed(width: 896, height: 414))
			.navigationBarTitle("about")
			.navigationBarHidden(false)
	}
}
