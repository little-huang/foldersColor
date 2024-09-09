//
//  ShapeView.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/9.
//

import Foundation
import SwiftUI
import Cocoa

struct ShapeView: View {
	
	private var heightWidthScale: Double = 0.84
	private var heightWidthTopScale: Double = 0.286
	private var width: Double = 130.0
	
			var body: some View {
				
				let height: Double = width * heightWidthScale
				let heightContent: Double = height * heightWidthScale
				let heightBackgroundFill: Double = heightContent + (height * 0.075)
				let widthTop: Double = width * heightWidthTopScale
				
				return VStack(alignment: .center, spacing: 0) {
						
						ZStack {
							
//							ZStack {
//
//								Ellipse() //椭圆形
//									.fill(Color.gray)
//									.frame(width: 20, height: 10)
//									.position(x: 96, y: 80)
//
//
//								RoundedRectangle(cornerRadius: 10)
//									.fill(Color.gray)
//									.frame(width: 20, height: 20)
//									.position(x: 96, y: 83)
//
//								RoundedRectangle(cornerRadius: 10)
//									.fill(Color.gray)
//									.frame(width: 20, height: 20)
//									.position(x: 97, y: 84)
//
//								RoundedRectangle(cornerRadius: 10)
//									.fill(Color.gray)
//									.frame(width: 20, height: 20)
//									.position(x: 98, y: 85)
//
//									RoundedRectangle(cornerRadius: 10)
//										.fill(Color.gray)
//										.frame(width: 20, height: 20)
//										.position(x: 99, y: 86)
//
//							}
//								.position(x: 0, y: 0)
//
//							RoundedRectangle(cornerRadius: 10)
//								.fill(Color.gray)
//								.frame(width: 30, height: 34)
//								.position(x: 22, y: 26)
//
//							RoundedRectangle(cornerRadius: 10)
//								.fill(Color.gray)
//								.frame(width: 30, height: 35)
//								.position(x: 23, y: 26)
//
//							RoundedRectangle(cornerRadius: 10)
//								.fill(Color.gray)
//								.frame(width: 30, height: 36)
//								.position(x: 24, y: 26)
//
//							RoundedRectangle(cornerRadius: 10)
//								.fill(Color.gray)
//								.frame(width: 30, height: 37)
//								.position(x: 25, y: 26)
//
//							RoundedRectangle(cornerRadius: 10)
//								.fill(Color.gray)
//								.frame(width: 30, height: 38)
//								.position(x: 24, y: 26)
//
//							RoundedRectangle(cornerRadius: 10)
//								.fill(Color.gray)
//								.frame(width: 30, height: 39)
//								.position(x:  23, y: 26)
//
//							RoundedRectangle(cornerRadius: 10, style: .continuous)
//								.fill(Color.gray)
//								.frame(width: widthTop, height: 40)
//								.position(x: widthTop / 2, y: 26)
//
//							RoundedRectangle(cornerRadius: 10, style: .continuous)
//								.fill(Color.gray)
//								.frame(width: width, height: heightBackgroundFill)
//
//							RoundedRectangle(cornerRadius: 10)
//								.fill(Color.blue)
//								.frame(width: width, height: heightContent)
//								.shadow(radius: 10)
//								.padding(
//									EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
//								)
							
						} // ZStack end
						
					} // VStack end
					.frame(width: width, height: height + 20)
				
			}
}

struct ShapeView_Previews: PreviewProvider {
		static var previews: some View {
			ShapeView()
		}
}
