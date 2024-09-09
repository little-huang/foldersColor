//
//  IconModalView.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/7/31.
//

import Foundation
import SwiftUI

struct ModalView: View {
	
		@State var isModalView = false
	
		var body: some View {
				VStack{
						Text("点击跳出ModalView窗口")
								.onTapGesture {
										self.isModalView.toggle()
						}
								.frame(width: 400, height: 500)
					
						.sheet(isPresented: $isModalView) {
								Text("新窗口")
						}
				}
		}
}

struct ModalView_Previews: PreviewProvider {
		static var previews: some View {
				ModalView()
		}
}
