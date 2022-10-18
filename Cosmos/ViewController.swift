//  Created on 2022/10/18.

import UIKit

class ViewController: UIViewController {
    
    let debugView = StarsBackground(frame: UIScreen.main.bounds, imageName: "6smallStar", starCount: 20, speed: 1.0)
    // DEBUGParallaxBackground(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(debugView)
    }

}

extension CGFloat {
    static func cosmos_random(min: CGFloat = 0, max: CGFloat = 1) -> CGFloat {
        let f = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return min * (1 - f) + f * max
    }
}
