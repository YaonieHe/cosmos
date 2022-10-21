//  Created on 2022/10/18.

import UIKit


class DEBUGInfiniteScrollView: UIView {
    private let scrollView = InfiniteScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(scrollView)
        scrollView.frame = self.bounds
        scrollView.showsHorizontalScrollIndicator = false
        addVisualIndicators()
    }
    
    
    private func addVisualIndicators() {
        let count: Int = 20
        let gap: CGFloat = 150
        let dx: CGFloat = 40
        
        let width = Double(count + 1) * gap + dx
        let cy = scrollView.frame.midY
        let w = scrollView.frame.width
        
        for x in 0...count {
            let point = CGPoint(x: Double(x) * gap + dx, y: cy)
            createIndicator(text: "\(x)", at: point)
        }
        var x: Int = 0
        var offset = dx
        while offset < w {
            let point = CGPoint(x: width + offset, y: cy)
            createIndicator(text: "\(x)", at: point)
            offset += gap
            x += 1
        }
        
        scrollView.contentSize = CGSize(width: width + w, height: 0)
    }
    
    private func createIndicator(text: String, at point: CGPoint) {
        let label = UILabel()
        label.text = text
        label.textColor = .red
        label.sizeToFit()
        label.center = point
        scrollView.addSubview(label)
    }
}
