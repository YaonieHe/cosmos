import UIKit

public class StarsBackground : InfiniteScrollView {
    convenience public init(frame: CGRect, imageName: String, starCount: Int, speed: CGFloat) {
        self.init(frame: frame)
        self.backgroundColor = .clear
        
        let adjustFrameSize = frame.width * speed
        
        let signalSignContentSize = adjustFrameSize * gapBetweenSigns
        let count = CGFloat(AstrologicalSignProvider.sharedInstance.order.count)
        
        contentSize = CGSize(width: signalSignContentSize * count + frame.width, height: 1.0)
        
        let img = UIImage(named: imageName)
        
        for currentFrame in 0 ..< Int(count) {
            let dx = signalSignContentSize * CGFloat(currentFrame)
            for _ in 0 ..< starCount {
                let x = dx + CGFloat.cosmos_random() * signalSignContentSize
                let y = CGFloat.cosmos_random() * frame.height
                var pt = CGPoint(x: x, y: y)
                
                let imageView = UIImageView(image: img)
                imageView.sizeToFit()
                imageView.center = pt
                self.addSubview(imageView)
                
                if currentFrame == 0 {
                    pt.x += count * signalSignContentSize
   
                    let imageView = UIImageView(image: img)
                    imageView.sizeToFit()
                    imageView.center = pt
                    self.addSubview(imageView)
                }
            }
            
            
        }
    }
    
}
