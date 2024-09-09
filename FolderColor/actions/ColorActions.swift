//
//  ColorsActions.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/8.
//

import Foundation
import SwiftUIFlux

struct ColorActions {
	
	struct SetColors: Action {
		let response: [FolderColor]
	}
	
	struct setCurrentSelectItem: Action {
		let response: FolderColor?
	}
	
	struct setCurrentSelectIndex: Action {
		let response: Int
	}
	
}
