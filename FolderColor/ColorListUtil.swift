//
//  ColorListUtil.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/8.
//

import Foundation

struct ColorListUtil {
	
	static public let shared = ColorListUtil()
	
	func getCurrentSelectedColorItem(colors: [FolderColor]) -> FolderColor? {
		
		if (colors.count <= 0) {
			return nil
		}
		
		var index: Int = -1
		var selectedItem: FolderColor?
		
		colors.forEach({ item in
			index += 1
			if (item.isSelected) {
				selectedItem = item
				return
			}
		})
		
		return selectedItem
		
	}
	
	func getCurrentSelectedIndex(colors: [FolderColor]) -> Int {
		
		var index: Int = -1
		var isSelected: Bool = false
		
		colors.forEach({ item in
			
			if (!isSelected) {
				index += 1
			}
			
			if (item.isSelected) {
				isSelected = item.isSelected
				return
			}
			
		})
		
		return index
	}
	
	func toggleColorsSelected(colors: [FolderColor], index: Int?) -> [FolderColor] {
		
		var newColors: [FolderColor] = []
		
		colors.forEach({ item in
			var newItem = item
			newItem.isSelected = false
			newColors.append(newItem)
		})
	  
		if (TypeUtil.shared.isNotNull(value: index) && index! > -1) {
			newColors[index!].isSelected = true
		}
		
		return newColors
	}

	// 生成随机颜色分量数组的函数
	func randomColorComponents() -> [CGFloat] {
		let red = CGFloat.random(in: 0...1)
		let green = CGFloat.random(in: 0...1)
		let blue = CGFloat.random(in: 0...1)
		let alpha = CGFloat.random(in: 0.5...1) // 保证颜色不完全透明
		return [red, green, blue, alpha]
	}
	
}
