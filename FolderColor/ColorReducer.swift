//
//  NoticeReducer.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/8.
//

import Foundation
import SwiftUIFlux

func colorReducer(state: ColorState, action: Action) -> ColorState {
	
		var state = state
	
		switch action {
			
		case let action as ColorActions.SetColors:
			state.colors = action.response
			
		case let action as ColorActions.setCurrentSelectItem:
			state.currentSelectItem = action.response
		
		case let action as ColorActions.setCurrentSelectIndex:
			state.currentSelectIndex = action.response
			
		default:
				break
		}

		return state
}
