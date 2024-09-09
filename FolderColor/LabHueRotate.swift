//
//  LabHueRotate.swift
//  FolderColor
//
//  Created by 黄宝成 on 2022/5/10.
//

import Foundation
import Cocoa
import Accelerate
import Combine

class LabHueRotate: ObservableObject {
		
	@Published var hueAngle: Float = 0.24
		
		@Published var outputImage: CGImage
		
		let width: Int
		let height: Int
		
		let image: NSImage
		let sourceCGImage: CGImage
		let rgbImageFormat: vImage_CGImageFormat
		
		var labImageFormat = vImage_CGImageFormat(bitsPerComponent: 8,
																							bitsPerPixel: 8 * 3,
																							colorSpace: CGColorSpace(name: CGColorSpace.genericLab)!,
																							bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue),
																							renderingIntent: .defaultIntent)!
		
		private var labSource: vImage_Buffer
		private var labDestination: vImage_Buffer
		private var rgbDestination: vImage_Buffer
		
		private var lDestination: vImage_Buffer
		private var aDestination: vImage_Buffer
		private var bDestination: vImage_Buffer
		
		private let rgbToLab: vImageConverter
		private let labToRGB: vImageConverter
		
		var cancellable: AnyCancellable?
		
		init?(image: NSImage) {
				self.image = image
				
				var rect = CGRect(origin: .zero,
													size: image.size)
				
				guard
						let sourceCGImage = image.cgImage(forProposedRect: &rect,
																							context: nil,
																							hints: nil),
						let rgbImageFormat = vImage_CGImageFormat(cgImage: sourceCGImage) else {
								return nil
				}
				
				self.sourceCGImage = sourceCGImage
				self.rgbImageFormat = rgbImageFormat
				
				outputImage = sourceCGImage
				width = Int(image.size.width)
				height = Int(image.size.height)
				
				do {
						let argbSourceBuffer = try vImage_Buffer(cgImage: sourceCGImage,
																										 format: rgbImageFormat)
						defer {
								argbSourceBuffer.free()
						}
						
						labSource = try vImage_Buffer(width: Int(image.size.width),
																					height: Int(image.size.height),
																					bitsPerPixel: labImageFormat.bitsPerPixel)
						
						labDestination = try vImage_Buffer(width: Int(image.size.width),
																							 height: Int(image.size.height),
																							 bitsPerPixel: labImageFormat.bitsPerPixel)
						
						lDestination = try vImage_Buffer(width: Int(image.size.width),
																						 height: Int(image.size.height),
																						 bitsPerPixel: labImageFormat.bitsPerComponent)
						
						aDestination = try vImage_Buffer(width: Int(image.size.width),
																						 height: Int(image.size.height),
																						 bitsPerPixel: labImageFormat.bitsPerComponent)
						
						bDestination = try vImage_Buffer(width: Int(image.size.width),
																						 height: Int(image.size.height),
																						 bitsPerPixel: labImageFormat.bitsPerComponent)
						
						rgbDestination = try vImage_Buffer(width: Int(image.size.width),
																							 height: Int(image.size.height),
																							 bitsPerPixel: rgbImageFormat.bitsPerPixel)
						
						rgbToLab = try vImageConverter.make(sourceFormat: rgbImageFormat,
																								destinationFormat: labImageFormat)
						
						labToRGB = try vImageConverter.make(sourceFormat: labImageFormat,
																								destinationFormat: rgbImageFormat)
						
						try rgbToLab.convert(source: argbSourceBuffer,
																 destination: &labSource)
				} catch {
						return nil
				}
				
				cancellable = $hueAngle
						.receive(on: DispatchQueue.global(qos: .userInteractive))
						.sink { _ in
								self.applyAdjustment()
						}
				
				applyAdjustment()
		}

		deinit {
				labSource.free()
				labDestination.free()
				rgbDestination.free()
				lDestination.free()
				aDestination.free()
				bDestination.free()
		}
		
		let semaphore = DispatchSemaphore(value: 1)

		func applyAdjustment() {
				semaphore.wait()
				
				let divisor: Int32 = 0x1000
				
				let rotationMatrix = [
						cos(hueAngle), -sin(hueAngle),
						sin(hueAngle),  cos(hueAngle)
						].map {
								return Int16($0 * Float(divisor))
				}
				
				let preBias = [Int16](repeating: -128, count: 2)
				let postBias = [Int32](repeating: 128 * divisor, count: 2)

				vImageConvert_RGB888toPlanar8(&labSource,
																			&lDestination, &aDestination, &bDestination,
																			vImage_Flags(kvImageNoFlags))
				
				[bDestination, aDestination].withUnsafeBufferPointer { bufferPointer in
						
						var src: [UnsafePointer<vImage_Buffer>?] = (0...1).map {
								bufferPointer.baseAddress! + $0
						}
						
						var dst: [UnsafePointer<vImage_Buffer>?] = (0...1).map {
								bufferPointer.baseAddress! + $0
						}
 
						vImageMatrixMultiply_Planar8(&src,
																				 &dst,
																				 2, 2,
																				 rotationMatrix,
																				 divisor,
																				 preBias,
																				 postBias,
																				 0)
				}
				
				vImageConvert_Planar8toRGB888(&lDestination, &aDestination, &bDestination,
																			&labDestination,
																			vImage_Flags(kvImageNoFlags))
				
				do {
						try labToRGB.convert(source: labDestination,
																 destination: &rgbDestination)
						
						let result = try rgbDestination.createCGImage(format: rgbImageFormat)
						
						DispatchQueue.main.async {
								self.outputImage = result
								self.semaphore.signal()
						}
				} catch {
						fatalError("Unable to create output image (\(error)).")
				}
		}
}
