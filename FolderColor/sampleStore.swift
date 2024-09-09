//
//  sampleStore.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/8.
//

import Foundation
import SwiftUIFlux

#if DEBUG
let sampleState = AppState(
	colorState: initColorState()
)

let sampleStore = Store<AppState>(
	reducer: appStateReducer,
	state: sampleState
)
#endif
