import UIKit

public class MenuRings : UIView {
    private var thickRingFrames: [CGRect] = [CGRect]()
    private var thickRing: Circle!
    
    private var thinRings: [Circle] = [Circle]()
    private var thinRingFrames: [CGRect] = [CGRect]()
    
    private var dashedRings: [Circle] = [Circle]()
    
    private var menuDividingLines: [Line] = [Line]()
    
    private var menuIsVisible = false
    
    // MARK: -
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        createThickRing()
        createThinRing()
        createDashedRings()
        createMenuDividingLines()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: thick ring
    private func createThickRing() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let inner = Circle(center: center, radius: 14)
        let outer = Circle(center: center, radius: 225)
        
        thickRingFrames = [inner.frame, outer.frame]
        
        inner.fillColor = UIColor.clear.cgColor
        inner.lineWidth = 3
        inner.strokeColor = UIColor.COSMOSblue.cgColor
        thickRing = inner
        
        self.addSubview(thickRing)
    }
    
    func thickRingOut() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.thickRing.frame = self.thickRingFrames[1]
        }
    }
    
    func thickRingIn() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.thickRing.frame = self.thickRingFrames[0]
        }
    }
    
    // MARK: thin ring
    private func createThinRing() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        thinRings.append(Circle(center: center, radius: 8))
        thinRings.append(Circle(center: center, radius: 56))
        thinRings.append(Circle(center: center, radius: 78))
        thinRings.append(Circle(center: center, radius: 98))
        thinRings.append(Circle(center: center, radius: 102))
        thinRings.append(Circle(center: center, radius: 156))
        
        for i in 0..<thinRings.count {
            let ring = thinRings[i]
            ring.fillColor = UIColor.clear.cgColor
            ring.lineWidth = 1
            ring.strokeColor = UIColor.COSMOSblue.cgColor
            if i > 0 {
                ring.opacity = 0
            }
            
            thinRingFrames.append(ring.frame)
        }
        
        for ring in thinRings {
            self.addSubview(ring)
        }
    }
    
    func thinRingOut() {
        for i in 0..<self.thinRings.count-1 {
            let circle = self.thinRings[i]
            if i > 0 {
                UIView.animate(withDuration: 0.0375) {
                    circle.opacity = 1
                }
            }
            UIView.animate(withDuration: 0.075 + CGFloat(i) * 0.01, delay: 0, options: .curveEaseOut) {
                circle.frame = self.thinRingFrames[i + 1]
            }
        }
    }
    
    func thinRingIn() {
        for i in 1...self.thinRings.count {
            let circle = self.thinRings[self.thinRings.count - i]
            if self.thinRings.count - i > 0 {
                UIView.animate(withDuration: 0.0375) {
                    circle.opacity = 0
                }
            }
            UIView.animate(withDuration: 0.075 + CGFloat(i) * 0.01, delay: 0, options: .curveEaseOut) {
                circle.frame = self.thinRingFrames[self.thinRings.count - i]
            }
        }
        
    }
    
    // MARK: dashed ring
    private func createShortDashedRing() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let shortDashedRing = Circle(center: center, radius: 82+2)
        shortDashedRing.lineWidth = 0
        
        let pattern = [1.465,1.465,1.465,1.465,1.465,1.465,1.465,1.465*3.0] as [NSNumber]
        shortDashedRing.lineDashPattern = pattern
        shortDashedRing.strokeEnd = 0.995
        
        let angle = 1.5 * CGFloat.pi / 180
        shortDashedRing.setAffineTransform(CGAffineTransform(rotationAngle: angle))
        dashedRings.append(shortDashedRing)
    }
    
    private func createLongDashedRing() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let longDashedRing = Circle(center: center, radius: 82+2)
        longDashedRing.lineWidth = 0
        
        let pattern = [1.465, 1.465 * 9] as [NSNumber]
        longDashedRing.lineDashPattern = pattern
        longDashedRing.strokeEnd = 0.995
        let angle = -0.5 * CGFloat.pi / 180
        longDashedRing.setAffineTransform(CGAffineTransform(rotationAngle: angle))
        
        
        let maskFrame = longDashedRing.bounds
        let mask = Circle(center: CGPoint(x: maskFrame.midX, y: maskFrame.midY), radius: 82 + 4)
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.black.cgColor
        mask.lineWidth = 8
        longDashedRing.mask = mask
        
        dashedRings.append(longDashedRing)
    }
    
    private func createDashedRings() {
        createShortDashedRing()
        createLongDashedRing()
        
        for ring in dashedRings {
            ring.strokeColor = UIColor.COSMOSblue.cgColor
            ring.fillColor = UIColor.clear.cgColor
            ring.lineCap = .butt
            self.addSubview(ring)
        }
    }
    
    func dashedRingsOut() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.dashedRings[0].lineWidth = 4
            self.dashedRings[1].lineWidth = 12
        }
    }
    
    func dashedRingsIn() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.dashedRings[0].lineWidth = 0
            self.dashedRings[1].lineWidth = 0
        }
    }
    
    // MARK: menu divid line
    private func createMenuDividingLines() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let count = AstrologicalSignProvider.sharedInstance.order.count
        let unit = CGFloat.pi * 2 / CGFloat(count)
        
        for i in 0..<count {
            let line = Line(begin: .zero, end: CGPoint(x: 54, y: 0))
            line.strokeColor = UIColor.COSMOSblue.cgColor
            line.anchorPoint = CGPoint(x: -1.8888, y: 0)
            line.center = center
            line.setAffineTransform(CGAffineTransform(rotationAngle: unit * CGFloat(i)))
            line.lineCap = .butt
            line.lineWidth = 1
            line.strokeEnd = 0
            self.addSubview(line)
            menuDividingLines.append(line)
        }
    }
    
    func revealHideDividingLins(target: Double) {
        let count = menuDividingLines.count
        var indices: [Int] = [Int]()
        for i in 0..<count {
            indices.append(i)
        }
        
        for i in 0..<count {
            let randomIdx = Int.random(in: 0..<indices.count)
            let idx = indices[randomIdx]
            
            indices.remove(at: randomIdx)
            UIView.animate(withDuration: 0.1, delay: CGFloat(i) * 0.05) {
                self.menuDividingLines[idx].strokeEnd = target
            }
        }
    }
    
    // MARK: - debug
    func animOut() {
        delayWork(time: 1.0) {
            self.thickRingOut()
            self.thinRingOut()
            self.dashedRingsOut()
        }
        
        delayWork(time: 1.5) {
            self.revealHideDividingLins(target: 1)
        }
        
        delayWork(time: 2.5) {
            self.animIn()
        }
        
    }
    
    func animIn() {
        delayWork(time: 0.25) {
            self.revealHideDividingLins(target: 0)
        }
        
        delayWork(time: 1.0) {
            self.thickRingIn()
            self.thinRingIn()
            self.dashedRingsIn()
        }
        
        delayWork(time: 2.0) {
            self.animOut()
        }
    }
}
