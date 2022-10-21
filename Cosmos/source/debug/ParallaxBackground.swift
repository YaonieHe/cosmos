//  Created on 2022/10/18.

import UIKit

class ParallaxBackground: UIView {
    private let speeds : [CGFloat] = [0.08,0.0,0.10,0.12,0.15,1.0,0.8,1.0]
    private lazy var scrollviews = [InfiniteScrollView]()
    private let signCount : CGFloat = 12.0
    private var scrollViewOffsetContext: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        for i in 0..<speeds.count {
            let layer = createLayer(speed: speeds[i])
            self.addSubview(layer)
            scrollviews.append(layer)
        }
        
        if let topLayer = scrollviews.last {
            topLayer.addObserver(self, forKeyPath: "contentOffset", options: .new, context: &scrollViewOffsetContext)
        }
    }
    
    private func createLayer(speed: CGFloat) -> InfiniteScrollView {
        let frame = self.bounds
        let layer =  InfiniteScrollView(frame: frame)
        var contentSize = CGSizeMake(frame.width * 2 * signCount * speed, frame.height)
        contentSize.width += speed < 1.0 ? frame.width : 0
        layer.contentSize = contentSize
        
        let dx = contentSize.width / 100
        let dy = contentSize.height / CGFloat(speeds.count + 1)
        var center = CGPoint(x: dx, y: CGFloat(scrollviews.count + 1) * dy)
        let fontSize = CGFloat(scrollviews.count + 1) * 6
        let font = UIFont.systemFont(ofSize: fontSize)
        repeat {
            let label = UILabel()
            label.font = font
            label.text = "\(scrollviews.count)"
            label.sizeToFit()
            label.center = center
            layer.addSubview(label)
            center.x += dx
        } while center.x < contentSize.width
        
        return layer
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &scrollViewOffsetContext {
            let sv = object as! InfiniteScrollView
            let offset = sv.contentOffset
            
            for i in 0 ..< (scrollviews.count - 1) {
                let layer = scrollviews[i]
                layer.contentOffset = CGPointMake(offset.x * speeds[i], 0)
            }
        }
    }
}


class DEBUGParallaxBackground: UIView {
    private var background: ParallaxBackground!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        background = ParallaxBackground(frame: self.bounds)
        self.addSubview(background)
    }
}
