//
//  FolderIconView.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/12.
//

import Foundation
import SwiftUI

struct FolderIconView: View {
	
	var item: FolderColor
	
	var body: some View {
		VStack {
			
			ZStack {
				
				MyCustomShape().frame(width: 125, height: 100)
					.foregroundColor(
						Color.init(.sRGB, red: item.color[0], green: item.color[1], blue: item.color[2], opacity: 0.8)
					)

				MyCustomShape2().frame(width: 125, height: 76)
					.foregroundColor(
						Color.init(.sRGB, red: item.color[0], green: item.color[1], blue: item.color[2], opacity: 1)
					)
					.shadow(radius: 10)
					.padding(
						EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
					)
				
			}
			.frame(width: 125, height: 100)
			
		}
	}
}

struct FolderIconView_Previews: PreviewProvider {
		static var previews: some View {
			SVGView(
				item: FolderColor.init(color: [0, 0, 0, 1], isSelected: false)
			)
		}
}

