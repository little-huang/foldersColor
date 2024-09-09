//
//  AppReducer.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/8.
//

import Foundation
import SwiftUIFlux

func appStateReducer(state: AppState, action: Action) -> AppState {
	
	var state = state
	
	state.colorState = colorReducer(state: state.colorState, action: action)
	
	return state
}
