#if !os(macOS)
import UIKit
 
final public class SignView: UIView {
	
	private var lineArray: [[CGPoint]] = [[CGPoint]]()
	public var lineWidth = 2
	
	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		let firstPoint = touch.location(in: self)
		lineArray.append([CGPoint]())
		lineArray[lineArray.count - 1].append(firstPoint)
	}
	
	public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		let currentPoint = touch.location(in: self)
		lineArray[lineArray.count - 1].append(currentPoint)
		debugPrint(currentPoint)
		setNeedsDisplay()
	}
	
	public override func draw(_ rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else { return }
		draw(inContext: context)
	}
	
	private func draw(inContext context: CGContext) {
		context.setLineWidth(lineWidth)
		context.setStrokeColor(UIColor.black.cgColor)
		context.setLineCap(.round)
		
		for line in lineArray {
			guard let firstPoint = line.first else { continue }
			context.beginPath()
			context.move(to: firstPoint)
			for point in line.dropFirst() {
				context.addLine(to: point)
			}
			context.strokePath()
		}
	}
}

// MARK: - PUBLIC METHODS

extension SignView {
	public func reset() {
		lineArray = []
		setNeedsDisplay()
	}
	
	public func exportImage() -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
		guard let context = UIGraphicsGetCurrentContext() else { return nil }
		draw(inContext: context)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image
	}
	
	public func exportSignLine() -> [[CGPoint]] {
		return lineArray
	}
	
	public func load(points: [[CGPoint]]) {
		reset()
		lineArray = points
		setNeedsLayout()
	}
}
#endif
