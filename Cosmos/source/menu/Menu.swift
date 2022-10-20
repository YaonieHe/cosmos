import UIKit

class Menu : UIView {
    var menuRing: MenuRings!
    var menuIcons: MenuIcons!
    var menuSelector: MenuSelector!
    var menuShadow: MenuShadow!
    var shouldRevert: Bool = false
    
    var menuIsVisible = false
    
    let hideMenuSound = AudioPlayer("menuClose.mp3")!
    let revealMenuSound = AudioPlayer("menuOpen.mp3")!
    
    var instructionLabel : UILabel = UILabel()
    
    var stopShowInstruction: Bool = false
    
    typealias SelectionAction = (Int) -> Void
    var selectionAction: SelectionAction?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        menuRing = MenuRings(frame: bounds)
        menuSelector = MenuSelector(frame: bounds)
        menuIcons = MenuIcons(frame: bounds)
        menuShadow = MenuShadow(frame: bounds)
        
        addSubview(menuShadow)
        addSubview(menuRing)
        addSubview(menuSelector)
        addSubview(menuIcons)
        
        createGesture()
        createInstructionLabel()
        
        delayWork(time: 3.0) {
            if !self.stopShowInstruction {
                self.showInstruction()
            }
        }
        
        hideMenuSound.volume = 0.64
        revealMenuSound.volume = 0.64
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.addGestureRecognizer(longPress)
    }
    
    @objc func longPress(_ longPress: UILongPressGestureRecognizer) {
        
        switch longPress.state {
        case .began:
            self.revealMenu()
        case .cancelled, .failed, .ended:
            if menuIsVisible {
                self.hideMenu()
            } else {
                self.shouldRevert = true
            }
            if let sa = self.selectionAction {
                if self.menuSelector.currentSelection >= 0 {
                    sa(self.menuSelector.currentSelection)
                }
            }
        default: do{}
        }
        
        self.menuSelector.longPress(longPress)
    }
    
    func revealMenu() {
        if instructionLabel.alpha > 0 {
            hideInstruction()
        }
        self.stopShowInstruction = true
        
        revealMenuSound.play()
        self.menuIsVisible = false
        
        menuShadow.revealAnim()
        menuRing.thickRingOut()
        menuRing.thinRingOut()
        menuIcons.signIconsOut()
        
        delayWork(time: 0.33) {
            self.menuRing.revealHideDividingLins(target: 1)
            self.menuIcons.revealSignIcons()
        }
        
        delayWork(time: 0.66) {
            self.menuRing.dashedRingsOut()
        }
        
        delayWork(time: 1.0) {
            self.menuIsVisible = true
            if self.shouldRevert {
                self.hideMenu()
                self.shouldRevert = false
            }
        }
    }
    
    func hideMenu() {
        hideMenuSound.play()
        self.menuIsVisible = false
        
        menuRing.dashedRingsIn()
        menuRing.revealHideDividingLins(target: 0)
        
        delayWork(time: 0.16) {
            self.menuIcons.hideSignIcons()
        }
        delayWork(time: 0.57) {
            self.menuRing.thinRingIn()
        }
        delayWork(time: 0.66) {
            self.menuIcons.signIconsIn()
            self.menuRing.thickRingIn()
            self.menuShadow.hideAnim()
        }
    }
    
    func createInstructionLabel() {
        instructionLabel.bounds = CGRect(origin: .zero, size: CGSize(width: 320, height: 44))
        instructionLabel.text = "press and hold to open menu\nthen drag to choose a sign"
        instructionLabel.font = UIFont(name: "Menlo-Regular", size: 13)
        instructionLabel.textAlignment = .center
        instructionLabel.textColor = .white
        instructionLabel.center = CGPoint(x: bounds.midX, y: bounds.midY - 128)
        instructionLabel.numberOfLines = 2
        instructionLabel.alpha = 0
        self.addSubview(instructionLabel)
    }
    
    func showInstruction() {
        UIView.animate(withDuration: 2.5, delay: 0) {
            self.instructionLabel.alpha = 1
        }
    }
    
    func hideInstruction() {
        UIView.animate(withDuration: 0.25, delay: 0) {
            self.instructionLabel.alpha = 0
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.menuIsVisible {
            let cx = bounds.midX
            let cy = bounds.midY
            let r: CGFloat = 50
            let rect = CGRect(origin: CGPoint(x: cx - r, y: cy - r), size: CGSize(width: r * 2, height: r * 2))
            if !rect.contains(point) {
                return nil
            }
        }
        return super.hitTest(point, with: event)
    }
}
