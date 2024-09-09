//
//  ColorState.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/8.
//

import Foundation
import SwiftUI
import SwiftUIFlux

struct ColorState: FluxState, Codable {
	var colors: [FolderColor]
	var currentSelectItem: FolderColor?
	var currentSelectIndex: Int
}

func initColorState() -> ColorState {

	let defaultYellowColor = FolderColor(
		color: [1, 1, 0, 1],
		isSelected: true
	)
	let defaultRedColor = FolderColor(
		color: [1, 0, 0, 1],
		isSelected: false
	)
	let defaultGreenColor = FolderColor(
		color: [0, 1, 0, 1],
		isSelected: false
	)
	
	let colors: [FolderColor] = [
		defaultYellowColor,
		defaultRedColor,
		defaultGreenColor
	]
	
	return ColorState(
		colors: colors,
		currentSelectItem: defaultYellowColor,
		currentSelectIndex: 0
	)
}
