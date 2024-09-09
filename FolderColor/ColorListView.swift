//
//  ColorListView.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/7.
//

import Foundation
import SwiftUI

struct ColorItem {
  var color: CGColor
	var isSelected: Bool
}

struct ColorListView: View {
	
	private var gridItemLayout = [
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center),
		GridItem.init(.flexible(), spacing: 0, alignment: .center)
	]
	
	@State var colors: [ColorItem] = []
	
	private var currentSelectedColotItemIndex: Int = 0
	
	var currentSelectedColotItem: ColorItem? {
		get {
			
			var index: Int = -1
			var selectedItem: ColorItem?
			
			colors.forEach({ item in
				index += 1
				if (item.isSelected) {
					selectedItem = item
					return
				}
			})
			
			return selectedItem
		}
	}
	
	var currentSelectedIndex: Int {
		get {
			
			var index: Int = -1
			
			colors.forEach({ item in
				index += 1
				if (item.isSelected) {
					return
				}
			})
			
			return index
		}
	}
	
	func clearColorsSelected() {
		var newColors: [ColorItem] = []
		
		colors.forEach({ item in
			var newItem = item
			newItem.isSelected = false
			newColors.append(newItem)
		})
		
		colors = newColors
		
	}
	
	func selectColor(index: Int) {
		clearColorsSelected()
		colors[index].isSelected = true
	}
	
	func addColor() {
		
		clearColorsSelected()
		
		let newColor = currentSelectedColotItem == nil ? CGColor(red: 0, green: 0, blue: 0, alpha: 1) : colors[currentSelectedIndex].color
		
		colors.append(
			ColorItem(
				color: newColor,
				isSelected: true
			)
		)
	  
	}
	
	func removeColor() {
	  
		if (currentSelectedColotItem == nil) {
			return
		}
		
		colors.remove(at: currentSelectedIndex)
		
		if (colors.count > 0) {
			colors[currentSelectedIndex].isSelected = true
		}
		
	}
	
	func footer() -> some View {
		return HStack {
			
			Button(action: {
				addColor()
			}) {
				Text("+")
					.frame(width: 30)
			}
			
			if (currentSelectedColotItem != nil) {
				Button(action: {
					removeColor()
				}) {
					Text("-")
						.frame(width: 30)
				}
			}
			
		}
	}

	var body: some View {
		
		let currentColor = Binding<CGColor>(
			get: {
				if (currentSelectedColotItem != nil) {
					return colors[currentSelectedIndex].color
				}
				return CGColor(red: 0, green: 0, blue: 0, alpha: 1)
			},
			set: { newColor in
				if (currentSelectedColotItem != nil) {
					colors[currentSelectedIndex].color = newColor
				}
			}
		)
		
		return VStack {
			
			HStack {
				
			}
			
			Spacer()
			
			HStack {
				
				ScrollView {
					LazyVGrid (columns: gridItemLayout) {
						
						ForEach(0..<self.colors.count, id:\.self) { index in
							
//							ColorListItemView(item: colors[index])
//								.onTapGesture(perform: {
//									selectColor(index: index)
//								})
							
						}
						
					}
				}
				
			}.frame(width: 400, height: 200)
			
			HStack {
				
				footer()
				
				Spacer()
				
				HStack {
					
					if (currentSelectedColotItem != nil) {
						ColorPicker("", selection: currentColor)
					}
					
				}
				
			}
			.padding(
				EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30)
			)
			.frame(width: 400, height: 50)
			
		} // VStack end
			.frame(width: 400, height: 400)
		
	} // body end
	
}

struct ColorListView_Previews: PreviewProvider {
		static var previews: some View {
			ColorListView()
		}
}
