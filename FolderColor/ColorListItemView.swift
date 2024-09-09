//
//  ColorListItemView.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/7.
//

import Foundation
import SwiftUI


struct ColorListItemView: View {
	
	@Environment(\.colorScheme) var colorScheme
	
	var isLight: Bool {
		colorScheme == .light
	}
	
	var item: FolderColor

	var body: some View {
		
		VStack {
			ZStack {
				
				if (item.isSelected) {
				  
					Circle().fill(isLight ? Color.accentColor : Color.white)
					
					Circle().fill(
						Color.init(
							CGColor(red: item.color[0], green: item.color[1], blue: item.color[2], alpha: item.color[3])
						)
					).scaleEffect(0.8)
					
				} else {
					Circle().fill(
						Color.init(
							CGColor(red: item.color[0], green: item.color[1], blue: item.color[2], alpha: item.color[3])
						)
					)
				}
				
				
			}.frame(width: 26, height: 26)
		}
		
	} // body end
	
}

struct ColorListItemView_Previews: PreviewProvider {
		static var previews: some View {
			ColorListItemView(
				item: FolderColor(
					color: [0, 0, 0, 1],
					isSelected: true
				)
			)
		}
}

