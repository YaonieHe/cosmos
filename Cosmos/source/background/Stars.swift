import UIKit

let gapBetweenSigns: CGFloat = 10

class Stars : UIView, UIScrollViewDelegate {
    private let speeds: [CGFloat] = [0.08, 0, 0.1, 0.12, 0.15, 1.0, 0.8, 1.0]
    private var scrollviews: [InfiniteScrollView] = [InfiniteScrollView]()
    
    private var signLines: SignLines!
    private var bigStars: StarsBig!
    private var snapTargets: [CGFloat] = [CGFloat]()
    
    private var scrollviewOffsetContext = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .COSMOSbkgd
        
        let viewFrame = CGRect(origin: .zero, size: frame.size)
        
        scrollviews.append(StarsBackground(frame: viewFrame, imageName: "0Star", starCount: 20, speed: speeds[0]))
        scrollviews.append(createVignette())
        scrollviews.append(StarsBackground(frame: viewFrame, imageName: "2Star", starCount: 20, speed: speeds[2]))
        scrollviews.append(StarsBackground(frame: viewFrame, imageName: "3Star", starCount: 20, speed: speeds[3]))
        scrollviews.append(StarsBackground(frame: viewFrame, imageName: "4Star", starCount: 20, speed: speeds[4]))
        
        signLines = SignLines(frame: viewFrame)
        scrollviews.append(signLines)
        
        scrollviews.append(StarsSmall(frame: viewFrame, speed: speeds[6]))
        
        bigStars = StarsBig(frame: viewFrame)
        scrollviews.append(bigStars)
        
        for sv in scrollviews {
            self.addSubview(sv)
        }
        
        bigStars.addObserver(self, forKeyPath: "contentOffset", options: .new, context: &scrollviewOffsetContext)
        bigStars.delegate = self
        
        createSnapTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createVignette() -> InfiniteScrollView {
        let sv = InfiniteScrollView(frame: frame)
        let img = UIImage(named: "1vignette")
        let imageView = UIImageView(image: img)
        imageView.frame = frame
        sv.addSubview(imageView)
        return sv
    }
    
    private func createSnapTargets() {
        for i in 0 ... AstrologicalSignProvider.sharedInstance.order.count {
            snapTargets.append(gapBetweenSigns * CGFloat(i) * frame.width)
        }
    }
    
    private func snapIfNeeded(x: CGFloat, _ scrollView: UIScrollView) {
        var idx: Int = 0
        for target in snapTargets {
            let dist = abs(target - x)
            if dist <= frame.width / 2 {
                scrollView.setContentOffset(CGPoint(x: target, y: 0), animated: true)
                signLines.currentIndex = idx
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: DispatchWorkItem(block: {
                    self.signLines.revealCurentSignLines()
                }))
                return
            }
            idx += 1
        }
    }
    
    // MARK: -
    func goto(selection: Int) {
        let target = frame.width * gapBetweenSigns * CGFloat(selection)
        UIView.animate(withDuration: 3.0, delay: 0, options: .curveEaseOut) {
            self.bigStars.contentOffset = CGPoint(x: target, y: 0)
        } completion: { _ in
            self.signLines.revealCurentSignLines()
        }
        signLines.currentIndex = selection
    }
    
    // MARK: - observe
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &scrollviewOffsetContext {
            let sv = object as! InfiniteScrollView
            let offset = sv.contentOffset
            for i in 0 ..< (scrollviews.count - 1) {
                scrollviews[i].contentOffset = CGPointMake(offset.x * speeds[i], 0)
            }
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapIfNeeded(x: scrollView.contentOffset.x, scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (decelerate == false) {
            snapIfNeeded(x: scrollView.contentOffset.x, scrollView)
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        signLines.hideCurrentSignLines()
    }
}
