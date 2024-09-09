//
//  SVGView.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/11.
//

import Foundation
import SwiftUI

struct SVGDisplayView: View {
	
	var item: FolderColor
	
	var body: some View {
		VStack {
			
			ZStack {
				
				MyCustomShape().frame(width: 60, height: 46)
					.foregroundColor(
						Color.init(.sRGB, red: item.color[0], green: item.color[1], blue: item.color[2], opacity: item.color[3] * 0.8)
					)

				MyCustomShape2().frame(width: 60, height: 40)
					.foregroundColor(
						Color.init(.sRGB, red: item.color[0], green: item.color[1], blue: item.color[2], opacity: item.color[3])
					)
					.padding(
						EdgeInsets(top: 0, leading: 0, bottom: 14, trailing: 0)
					)
				
			}
			.frame(width: 60, height: 50)
			.padding(6)
			
		}
	}
}

struct SVGView: View {
	
	var item: FolderColor
	
	var body: some View {
		VStack {
			
			ZStack {
				
				MyCustomShape().frame(width: 125, height: 80)
					.foregroundColor(
						Color.init(.sRGB, red: item.color[0], green: item.color[1], blue: item.color[2], opacity: item.color[3] * 0.8)
					)

				MyCustomShape2().frame(width: 125, height: 76)
					.foregroundColor(
						Color.init(.sRGB, red: item.color[0], green: item.color[1], blue: item.color[2], opacity: item.color[3])
					)
					.padding(
						EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
					)
				
			}
			.frame(width: 125, height: 100)
			.padding(8)
			
		}
	}
}

struct MyCustomShape: Shape {
		func path(in rect: CGRect) -> Path {
				var path = Path()
				let width = rect.size.width
				let height = rect.size.height
				path.move(to: CGPoint(x: 0.04024*width, y: 0.99273*height))
				path.addLine(to: CGPoint(x: 0.95218*width, y: 0.99273*height))
				path.addCurve(to: CGPoint(x: 0.99242*width, y: 0.94163*height), control1: CGPoint(x: 0.9744*width, y: 0.99273*height), control2: CGPoint(x: 0.99242*width, y: 0.96985*height))
				path.addLine(to: CGPoint(x: 0.99242*width, y: 0.15572*height))
				path.addCurve(to: CGPoint(x: 0.95218*width, y: 0.10462*height), control1: CGPoint(x: 0.99242*width, y: 0.12751*height), control2: CGPoint(x: 0.9744*width, y: 0.10462*height))
				path.addLine(to: CGPoint(x: 0.39173*width, y: 0.10462*height))
				path.addCurve(to: CGPoint(x: 0.33829*width, y: 0.07052*height), control1: CGPoint(x: 0.37068*width, y: 0.10462*height), control2: CGPoint(x: 0.35086*width, y: 0.09198*height))
				path.addLine(to: CGPoint(x: 0.3112*width, y: 0.0243*height))
				path.addCurve(to: CGPoint(x: 0.27311*width, y: 0), control1: CGPoint(x: 0.30224*width, y: 0.009*height), control2: CGPoint(x: 0.28812*width, y: 0))
				path.addLine(to: CGPoint(x: 0.04024*width, y: 0))
				path.addCurve(to: CGPoint(x: 0, y: 0.05111*height), control1: CGPoint(x: 0.01802*width, y: 0.00001*height), control2: CGPoint(x: 0, y: 0.0229*height))
				path.addLine(to: CGPoint(x: 0, y: 0.94164*height))
				path.addCurve(to: CGPoint(x: 0.04024*width, y: 0.99273*height), control1: CGPoint(x: 0, y: 0.96985*height), control2: CGPoint(x: 0.01802*width, y: 0.99273*height))
				path.closeSubpath()
				return path
		}
}


struct MyCustomShape2: Shape {
		func path(in rect: CGRect) -> Path {
				var path = Path()
				let width = rect.size.width
				let height = rect.size.height
				path.move(to: CGPoint(x: 0.95217*width, y: 1.28094*height))
				path.addLine(to: CGPoint(x: 0.04024*width, y: 1.28094*height))
				path.addCurve(to: CGPoint(x: 0, y: 1.21501*height), control1: CGPoint(x: 0.01802*width, y: 1.28094*height), control2: CGPoint(x: 0, y: 1.25142*height))
				path.addLine(to: CGPoint(x: 0, y: 0.35335*height))
				path.addCurve(to: CGPoint(x: 0.04024*width, y: 0.28742*height), control1: CGPoint(x: 0, y: 0.31694*height), control2: CGPoint(x: 0.01802*width, y: 0.28742*height))
				path.addLine(to: CGPoint(x: 0.95218*width, y: 0.28742*height))
				path.addCurve(to: CGPoint(x: 0.99242*width, y: 0.35335*height), control1: CGPoint(x: 0.9744*width, y: 0.28742*height), control2: CGPoint(x: 0.99242*width, y: 0.31694*height))
				path.addLine(to: CGPoint(x: 0.99242*width, y: 1.21501*height))
				path.addCurve(to: CGPoint(x: 0.95217*width, y: 1.28094*height), control1: CGPoint(x: 0.99241*width, y: 1.25142*height), control2: CGPoint(x: 0.97439*width, y: 1.28094*height))
				path.closeSubpath()
				return path
		}
}

struct MyCustomShape3: Shape {
		func path(in rect: CGRect) -> Path {
				var path = Path()
				let width = rect.size.width
				let height = rect.size.height
				path.move(to: CGPoint(x: 1.04546*width, y: 44.25754*height))
				path.addLine(to: CGPoint(x: 0.06012*width, y: 44.25754*height))
				path.addCurve(to: CGPoint(x: 0.05398*width, y: 43.90744*height), control1: CGPoint(x: 0.05673*width, y: 44.25754*height), control2: CGPoint(x: 0.05398*width, y: 44.1007*height))
				path.addCurve(to: CGPoint(x: 0.06012*width, y: 43.55734*height), control1: CGPoint(x: 0.05398*width, y: 43.71419*height), control2: CGPoint(x: 0.05673*width, y: 43.55734*height))
				path.addLine(to: CGPoint(x: 1.04547*width, y: 43.55734*height))
				path.addCurve(to: CGPoint(x: 1.05161*width, y: 43.90744*height), control1: CGPoint(x: 1.04886*width, y: 43.55734*height), control2: CGPoint(x: 1.05161*width, y: 43.71419*height))
				path.addCurve(to: CGPoint(x: 1.04546*width, y: 44.25754*height), control1: CGPoint(x: 1.05161*width, y: 44.1007*height), control2: CGPoint(x: 1.04886*width, y: 44.25754*height))
				path.closeSubpath()
				return path
		}
}

struct MyCustomShape4: Shape {
		func path(in rect: CGRect) -> Path {
				var path = Path()
				let width = rect.size.width
				let height = rect.size.height
				path.move(to: CGPoint(x: 1.04546*width, y: 47.12276*height))
				path.addLine(to: CGPoint(x: 0.06012*width, y: 47.12276*height))
				path.addCurve(to: CGPoint(x: 0.1398*width, y: 46.77266*height), control1: CGPoint(x: 0.05673*width, y: 47.12276*height), control2: CGPoint(x: 0.05398*width, y: 46.96592*height))
				path.addCurve(to: CGPoint(x: 0.06012*width, y: 46.42256*height), control1: CGPoint(x: 0.05398*width, y: 46.5794*height), control2: CGPoint(x: 0.05673*width, y: 46.42256*height))
				path.addLine(to: CGPoint(x: 1.04547*width, y: 92.42256*height))
				path.addCurve(to: CGPoint(x: 1.05161*width, y: 46.77266*height), control1: CGPoint(x: 1.04886*width, y: 46.42256*height), control2: CGPoint(x: 1.05161*width, y: 46.5794*height))
				path.addCurve(to: CGPoint(x: 1.04546*width, y: 47.12276*height), control1: CGPoint(x: 1.05161*width, y: 46.96592*height), control2: CGPoint(x: 1.04886*width, y: 47.12276*height))
				path.closeSubpath()
				return path
		}
}


struct SVGView_Previews: PreviewProvider {
		static var previews: some View {
			SVGView(
				item: FolderColor.init(color: defaultFolderColorComponents, isSelected: false)
			)
		}
}

