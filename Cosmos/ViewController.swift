//  Created on 2022/10/18.

import UIKit

class ViewController: UIViewController {
    
    let debugView = Cosmos(frame: UIScreen.main.bounds)
    // StarsSmall(frame: UIScreen.main.bounds, speed: 1.0)
    // SignLines(frame: UIScreen.main.bounds)
    // StarsBackground(frame: UIScreen.main.bounds, imageName: "6smallStar", starCount: 20, speed: 1.0)
    // DEBUGParallaxBackground(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .COSMOSbkgd
        self.view.addSubview(debugView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}

extension CGFloat {
    static func cosmos_random(min: CGFloat = 0, max: CGFloat = 1) -> CGFloat {
        let f = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return min * (1 - f) + f * max
    }
}

extension UIColor {
    static let COSMOSprpl = UIColor(red:0.565, green: 0.075, blue: 0.996, alpha: 1.0)
    static let COSMOSblue = UIColor(red: 0.094, green: 0.271, blue: 1.0, alpha: 1.0)
    static let COSMOSbkgd = UIColor(red: 0.078, green: 0.118, blue: 0.306, alpha: 1.0)
}

func delayWork(time: CGFloat, _ work: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: DispatchWorkItem(block: {
        work()
    }))
}
