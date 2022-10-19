import UIKit

typealias AstrologicalSignFunction = () -> AstrologicalSign

struct AstrologicalSign {
    var shape: UIBezierPath!
    var big: [CGPoint]!
    var small: [CGPoint]!
    var lines: [[CGPoint]]!
}

class AstrologicalSignProvider : NSObject {
    static let sharedInstance = AstrologicalSignProvider()
    
    let order = ["pisces", "aries", "taurus", "gemini", "cancer", "leo", "virgo", "libra", "scorpio", "sagittarius", "capricorn", "aquarius"]
    
    private var mappings = [String : AstrologicalSignFunction]()

    //MARK: - Initialization
    override init() {
        super.init()
        mappings = [
            "pisces":pisces,
            "aries":aries,
            "taurus":taurus,
            "gemini":gemini,
            "cancer":cancer,
            "leo":leo,
            "virgo":virgo,
            "libra":libra,
            "scorpio":scorpio,
            "sagittarius":sagittarius,
            "capricorn":capricorn,
            "aquarius":aquarius
        ]
    }

    //MARK: - Get
    func get(sign: String) -> AstrologicalSign? {
        guard let function = mappings[sign.lowercased()] else {
            assertionFailure()
            return nil
        }
        return function()
    }


    //MARK: - Signs
    //The following methods each represent an astrological sign, whose points (big/small) are calculated relative to {0,0}
    func taurus() -> AstrologicalSign {
        let bezier = UIBezierPath()

        bezier.move(to: CGPointMake(0, 0))
        bezier.addCurve(to: CGPointMake(6.3, 0), controlPoint1:CGPointMake(6.4, 10.2), controlPoint2: CGPointMake(15.2, 10.2))
        bezier.addCurve(to: CGPointMake(20.8, 10.2), controlPoint1:CGPointMake(25.4, 14.8), controlPoint2: CGPointMake(25.4, 20.4))
        bezier.addCurve(to: CGPointMake(25.4, 26), controlPoint1:CGPointMake(20.8, 30.6), controlPoint2: CGPointMake(15.2, 30.6))
        bezier.addCurve(to: CGPointMake(9.6, 30.6), controlPoint1:CGPointMake(5, 26), controlPoint2: CGPointMake(5, 20.4))
        bezier.addCurve(to: CGPointMake(5, 14.8), controlPoint1:CGPointMake(9.6, 10.2), controlPoint2: CGPointMake(15.2, 10.2))
        bezier.addCurve(to: CGPointMake(24, 10.2), controlPoint1:CGPointMake(24.1, 0), controlPoint2: CGPointMake(30.4, 0))

        var sign = AstrologicalSign()
        sign.shape = bezier

        let big = [
            CGPointMake(-53.25,-208.2),
            CGPointMake(-56.75,-26.2)]
        sign.big = big

        let small = [
            CGPointMake(-134.75,-174.2),
            CGPointMake(-24.25,-32.2),
            CGPointMake(-24.25,-9.2),
            CGPointMake(-32.75,10.8),
            CGPointMake(87.75,-6.2),
            CGPointMake(-15.75,67.3),
            CGPointMake(31.75,142.3)]
        sign.small = small

        let lines = [
            [big[0],small[1]],
            [big[1],small[0]],
            [small[1],small[4]],
            [small[1],small[2]],
            [small[2],small[3]],
            [big[1],small[3]],
            [small[3],small[5]],
            [small[5],small[6]]]
        sign.lines = lines

        return sign
    }

    func aries() -> AstrologicalSign {
        let bezier = UIBezierPath()

        bezier.move(to: CGPointMake(2.8, 15.5))
        bezier.addCurve(to: CGPointMake(1.1, 13.9), controlPoint1:CGPointMake(0, 11.6), controlPoint2: CGPointMake(0, 9))
        bezier.addCurve(to: CGPointMake(0, 4), controlPoint1:CGPointMake(4, 0), controlPoint2: CGPointMake(9, 0))
        bezier.addCurve(to: CGPointMake(14, 0), controlPoint1:CGPointMake(18, 4), controlPoint2: CGPointMake(18, 9))
        bezier.addLine(to: CGPointMake(18, 28.9))

        bezier.move(to: CGPointMake(18, 28.9))
        bezier.addLine(to: CGPointMake(18, 9))
        bezier.addCurve(to: CGPointMake(18, 4), controlPoint1:CGPointMake(22, 0), controlPoint2: CGPointMake(27, 0))
        bezier.addCurve(to: CGPointMake(32, 0), controlPoint1:CGPointMake(36, 4), controlPoint2: CGPointMake(36, 9))
        bezier.addCurve(to: CGPointMake(36, 11.6), controlPoint1:CGPointMake(34.9, 13.9), controlPoint2: CGPointMake(33.2, 15.5))

        var sign = AstrologicalSign()
        sign.shape = bezier

        let big = [
            CGPointMake(58.0,-57.7),
            CGPointMake(125.50, -17.7)]
        sign.big = big

        let small = [
            CGPointMake(-134.5,-95.2),
            CGPointMake(137.0,11.3)]
        sign.small = small

        let lines = [
            [big[0],small[0]],
            [big[1],big[0]],
            [big[1],small[1]]]
        sign.lines = lines

        return sign
    }

    func gemini() -> AstrologicalSign {
        let bezier = UIBezierPath()

        bezier.move(to: CGPointMake(26, 0))
        bezier.addCurve(to: CGPointMake(26, 0), controlPoint1:CGPointMake(24.2, 5.3), controlPoint2: CGPointMake(13, 5.3))
        bezier.addCurve(to: CGPointMake(1.8, 5.3), controlPoint1:CGPointMake(0, 0), controlPoint2: CGPointMake(0, 0))

        bezier.move(to: CGPointMake(0.1, 34.7))
        bezier.addCurve(to: CGPointMake(0.1, 34.7), controlPoint1:CGPointMake(1.9, 29.4), controlPoint2: CGPointMake(13.1, 29.4))
        bezier.addCurve(to: CGPointMake(24.3, 29.4), controlPoint1:CGPointMake(26.1, 34.7), controlPoint2: CGPointMake(26.1, 34.7))

        bezier.move(to: CGPointMake(8.1, 5))
        bezier.addLine(to: CGPointMake(8.1, 29.6))

        bezier.move(to: CGPointMake(18, 5))
        bezier.addLine(to: CGPointMake(18, 29.6))

        var sign = AstrologicalSign()
        sign.shape = bezier

        let big = [
            CGPointMake(-96.75,-193.7),
            CGPointMake(-133.25,-142.2),
            CGPointMake(77.25,19.8)]
        sign.big = big

        let small = [
            CGPointMake(24.25,-218.7),
            CGPointMake(-29.75,-167.7),
            CGPointMake(-105.25,-125.7),
            CGPointMake(-134.75,-92.7),
            CGPointMake(54.75,-98.7),
            CGPointMake(120.75,-66.2),
            CGPointMake(145.75,-67.2),
            CGPointMake(103.75,-34.2),
            CGPointMake(-58.75,-55.7),
            CGPointMake(-9.25,-37.2),
            CGPointMake(-56.25,18.8),
            CGPointMake(53.75,67.8)]
        sign.small = small

        let lines = [
            [big[0],small[1]],
            [big[1],small[2]],
            [small[0],small[1]],
            [small[1],small[2]],
            [small[2],small[3]],
            [small[2],small[8]],
            [small[8],small[10]],
            [small[10],small[11]],
            [small[8],small[9]],
            [small[9],big[2]],
            [small[1],small[4]],
            [small[4],small[7]],
            [small[4],small[5]],
            [small[5],small[6]]]
        sign.lines = lines

        return sign
    }

    func cancer() -> AstrologicalSign {
        let bezier = UIBezierPath()

        bezier.move(to: CGPointMake(0, 8.1))
        bezier.addCurve(to: CGPointMake(1.9, 4.5), controlPoint1:CGPointMake(6.4, 0), controlPoint2: CGPointMake(14.2, 0))
        bezier.addCurve(to: CGPointMake(22.1, 0), controlPoint1:CGPointMake(28.4, 4), controlPoint2: CGPointMake(28.4, 8.8))
        bezier.addCurve(to: CGPointMake(28.4, 11.7), controlPoint1:CGPointMake(26.1, 14), controlPoint2: CGPointMake(23.2, 14))
        bezier.addCurve(to: CGPointMake(20.3, 14), controlPoint1:CGPointMake(18, 11.7), controlPoint2: CGPointMake(18, 8.8))
        bezier.addCurve(to: CGPointMake(18, 5.9), controlPoint1:CGPointMake(20.3, 3.6), controlPoint2: CGPointMake(23.2, 3.6))
        bezier.addCurve(to: CGPointMake(26.1, 3.6), controlPoint1:CGPointMake(28.4, 5.9), controlPoint2: CGPointMake(28.4, 8.8))

        bezier.move(to: CGPointMake(28.4, 21.3))
        bezier.addCurve(to: CGPointMake(26.5, 24.9), controlPoint1:CGPointMake(22, 29.4), controlPoint2: CGPointMake(14.2, 29.4))
        bezier.addCurve(to: CGPointMake(6.3, 29.4), controlPoint1:CGPointMake(0, 25.4), controlPoint2: CGPointMake(0, 20.6))
        bezier.addCurve(to: CGPointMake(0, 17.7), controlPoint1:CGPointMake(2.3, 15.4), controlPoint2: CGPointMake(5.2, 15.4))
        bezier.addCurve(to: CGPointMake(8.1, 15.4), controlPoint1:CGPointMake(10.4, 17.7), controlPoint2: CGPointMake(10.4, 20.6))
        bezier.addCurve(to: CGPointMake(10.4, 23.5), controlPoint1:CGPointMake(8.1, 25.8), controlPoint2: CGPointMake(5.2, 25.8))
        bezier.addCurve(to: CGPointMake(2.3, 25.8), controlPoint1:CGPointMake(0, 23.5), controlPoint2: CGPointMake(0, 20.6))

        var sign = AstrologicalSign()
        sign.shape = bezier

        let big = [
            CGPointMake(-68.25,-21.2),
            CGPointMake(46.25,141.8)]
        sign.big = big

        let small = [
            CGPointMake(-66.75,-209.2),
            CGPointMake(-59.25,-80.7),
            CGPointMake(-126.75,90.8),
            CGPointMake(5.75,81.8)]
        sign.small = small

        let lines = [
            [big[0],small[1]],
            [big[1],small[3]],
            [small[0],small[1]],
            [big[0],small[2]],
            [big[0],small[3]]]
        sign.lines = lines

        return sign
    }

    func leo() -> AstrologicalSign {
        let bezier = UIBezierPath()

        bezier.move(to: CGPointMake(10.4, 19.6))
        bezier.addCurve(to: CGPointMake(10.4, 16.7), controlPoint1:CGPointMake(8.1, 14.4), controlPoint2: CGPointMake(5.2, 14.4))
        bezier.addCurve(to: CGPointMake(2.3, 14.4), controlPoint1:CGPointMake(0, 16.7), controlPoint2: CGPointMake(0, 19.6))
        bezier.addCurve(to: CGPointMake(0, 22.5), controlPoint1:CGPointMake(2.3, 24.8), controlPoint2: CGPointMake(5.2, 24.8))
        bezier.addCurve(to: CGPointMake(8.1, 24.8), controlPoint1:CGPointMake(10.4, 22.4), controlPoint2: CGPointMake(10.4, 19.6))
        bezier.addCurve(to: CGPointMake(10.4, 14.8), controlPoint1:CGPointMake(6, 15), controlPoint2: CGPointMake(6, 9.1))
        bezier.addCurve(to: CGPointMake(6, 4), controlPoint1:CGPointMake(10.1, 0), controlPoint2: CGPointMake(15.1, 0))
        bezier.addCurve(to: CGPointMake(20.1, 0), controlPoint1:CGPointMake(24.2, 4.1), controlPoint2: CGPointMake(24.2, 9.1))
        bezier.addCurve(to: CGPointMake(24.2, 17.2), controlPoint1:CGPointMake(17, 18.5), controlPoint2: CGPointMake(17, 25.6))
        bezier.addCurve(to: CGPointMake(17, 28.5), controlPoint1:CGPointMake(19.3, 30.8), controlPoint2: CGPointMake(22.2, 30.8))
        bezier.addCurve(to: CGPointMake(25.1, 30.8), controlPoint1:CGPointMake(27.4, 28.5), controlPoint2: CGPointMake(27.4, 25.6))

        var sign = AstrologicalSign()
        sign.shape = bezier

        let big = [
            CGPointMake(-60.25,-33.7),
            CGPointMake(68.75,-50.2),
            CGPointMake(110.75,50.3)]
        sign.big = big

        let small = [
            CGPointMake(138.75,-129.2),
            CGPointMake(118.75,-157.2),
            CGPointMake(66.75,-103.7),
            CGPointMake(-31.75,-34.2),
            CGPointMake(103.75,-14.7),
            CGPointMake(-55.75,40.8),
            CGPointMake(-138.25,62.3)]
        sign.small = small

        let lines = [
            [small[0],small[1]],
            [small[1],small[2]],
            [small[2],big[1]],
            [big[1],small[4]],
            [small[4],big[2]],
            [big[2],small[5]],
            [small[5],small[6]],
            [small[6],big[0]],
            [big[0],small[3]],
            [small[3],big[1]]]
        sign.lines = lines

        return sign
    }

    func virgo() -> AstrologicalSign {
        let bezier = UIBezierPath()

        bezier.move(to: CGPointMake(30, 12.2))
        bezier.addCurve(to: CGPointMake(30, 9.4), controlPoint1:CGPointMake(32.2, 7.2), controlPoint2: CGPointMake(35, 7.2))
        bezier.addCurve(to: CGPointMake(37.8, 7.2), controlPoint1:CGPointMake(40, 9.4), controlPoint2: CGPointMake(40, 12.2))
        bezier.addCurve(to: CGPointMake(40, 23.7), controlPoint1:CGPointMake(24.3, 31.5), controlPoint2: CGPointMake(24.3, 31.5))

        bezier.move(to: CGPointMake(10, 24.1))
        bezier.addLine(to: CGPointMake(10, 5))
        bezier.addCurve(to: CGPointMake(10, 2.2), controlPoint1:CGPointMake(7.8, 0), controlPoint2: CGPointMake(5, 0))
        bezier.addCurve(to: CGPointMake(2.2, 0), controlPoint1:CGPointMake(0, 2.2), controlPoint2: CGPointMake(0, 5))

        bezier.move(to: CGPointMake(20, 24.1))
        bezier.addLine(to: CGPointMake(20, 5))
        bezier.addCurve(to: CGPointMake(20, 2.2), controlPoint1:CGPointMake(17.8, 0), controlPoint2: CGPointMake(15, 0))
        bezier.addCurve(to: CGPointMake(12.2, 0), controlPoint1:CGPointMake(10, 2.2), controlPoint2: CGPointMake(10, 5))

        bezier.move(to: CGPointMake(39.1, 29.8))
        bezier.addCurve(to: CGPointMake(34.5, 29.8), controlPoint1:CGPointMake(30, 28), controlPoint2: CGPointMake(30, 19.2))
        bezier.addLine(to: CGPointMake(30, 5))
        bezier.addCurve(to: CGPointMake(30, 2.2), controlPoint1:CGPointMake(27.8, 0), controlPoint2: CGPointMake(25, 0))
        bezier.addCurve(to: CGPointMake(22.2, 0), controlPoint1:CGPointMake(20, 2.2), controlPoint2: CGPointMake(20, 5))

        var sign = AstrologicalSign()
        sign.shape = bezier

        let big = [
            CGPointMake(-28.75,-248.2),
            CGPointMake(-134.75,-109.2),
            CGPointMake(93.75,-56.7),
            CGPointMake(-53.25,98.8)]
        sign.big = big

        let small = [
            CGPointMake(-9.25,-186.7),
            CGPointMake(-2.25,-144.7),
            CGPointMake(-56.25,-116.7),
            CGPointMake(39.25,-86.7),
            CGPointMake(-18.25,-39.7),
            CGPointMake(-44.25,10.3),
            CGPointMake(87.25,35.8),
            CGPointMake(33.75,42.3),
            CGPointMake(31.75,68.8),
            CGPointMake(24.25,94.8)]
        sign.small = small

        let lines = [
            [big[0],small[0]],
            [small[0],small[1]],
            [small[1],small[3]],
            [small[3],big[2]],
            [big[2],small[6]],
            [small[6],small[7]],
            [small[7],small[8]],
            [small[8],small[9]],
            [small[1],small[2]],
            [small[2],big[1]],
            [small[2],small[4]],
            [big[2],small[4]],
            [small[4],small[5]],
            [small[5],big[3]]]
        sign.lines = lines

        return sign
    }

    func libra() -> AstrologicalSign {
        let bezier = UIBezierPath()

        bezier.move(to: CGPointMake(37.5, 11.3))
        bezier.addLine(to: CGPointMake(30, 11.3))
        bezier.addCurve(to: CGPointMake(30, 5.1), controlPoint1:CGPointMake(24.9, 0), controlPoint2: CGPointMake(18.7, 0))
        bezier.addCurve(to: CGPointMake(12.5, 0), controlPoint1:CGPointMake(7.4, 5.1), controlPoint2: CGPointMake(7.4, 11.3))
        bezier.addLine(to: CGPointMake(0, 11.3))

        bezier.move(to: CGPointMake(0, 20.2))
        bezier.addLine(to: CGPointMake(37.5, 20.2))

        var sign = AstrologicalSign()
        sign.shape = bezier

        let big = [
            CGPointMake(-26.25,-121.7)]
        sign.big = big

        let small = [
            CGPointMake(-141.25,-37.7),
            CGPointMake(-16.75,-35.7),
            CGPointMake(96.75,-39.2),
            CGPointMake(-70.75,65.3),
            CGPointMake(-64.75,102.3),
            CGPointMake(-53.25,147.3),
            CGPointMake(120.75,92.3),
            CGPointMake(118.75,109.3),
            CGPointMake(141.25,117.8)]
        sign.small = small

        let lines = [
            [big[0],small[0]],
            [big[0],small[2]],
            [small[0],small[1]],
            [small[2],small[1]],
            [small[0],small[3]],
            [small[3],small[4]],
            [small[4],small[5]],
            [small[2],small[6]],
            [small[6],small[7]],
            [small[7],small[8]]]
        sign.lines = lines

        return sign
    }

    func pisces() -> AstrologicalSign {
        let bezier = UIBezierPath()

        bezier.move(to: CGPointMake(2.8, 0.1))
        bezier.addCurve(to: CGPointMake(2.8, 0.1), controlPoint1:CGPointMake(9.2, 1.9), controlPoint2: CGPointMake(9.2, 13.1))
        bezier.addCurve(to: CGPointMake(9.2, 24.3), controlPoint1:CGPointMake(2.8, 26.1), controlPoint2: CGPointMake(2.8, 26.1))

        bezier.move(to: CGPointMake(25.4, 26))
        bezier.addCurve(to: CGPointMake(25.4, 26), controlPoint1:CGPointMake(19, 24.2), controlPoint2: CGPointMake(19, 13))
        bezier.addCurve(to: CGPointMake(19, 1.8), controlPoint1:CGPointMake(25.4, 0), controlPoint2: CGPointMake(25.4, 0))

        bezier.move(to: CGPointMake(0, 13.1))
        bezier.addLine(to: CGPointMake(28.2, 13.1))

        var sign = AstrologicalSign()
        sign.shape = bezier

        let big = [
            CGPointMake(-103.0,-81.7),
            CGPointMake(120.5,-168.2)]
        sign.big = big

        sign.big = big

        let small = [
            CGPointMake(-127.5,-161.2),
            CGPointMake(-129.0,-143.2),
            CGPointMake(-112.0,-136.2),
            CGPointMake(-103.0,-38.2),
            CGPointMake(-107.5,11.3),
            CGPointMake(-82.0,-20.2),
            CGPointMake(-66.0,-32.7),
            CGPointMake(-28.5,-67.7),
            CGPointMake(-8.0,-78.7),
            CGPointMake(58.0,-129.7),
            CGPointMake(84.5,-147.7),
            CGPointMake(92.5,-163.7),
            CGPointMake(106.0,-130.2),
            CGPointMake(125.5,-149.2),
            CGPointMake(129.5,-188.2)]
        sign.small = small

        let lines = [
            [big[0],small[3]],
            [big[1],small[14]],
            [small[0],small[1]],
            [small[1],small[2]],
            [small[2],big[0]],
            [small[3],small[4]],
            [small[4],small[5]],
            [small[5],small[6]],
            [small[6],small[7]],
            [small[7],small[8]],
            [small[8],small[9]],
            [small[9],small[10]],
            [small[10],small[11]],
            [small[11],big[1]],
            [small[10],small[12]],
            [small[12],small[13]],
            [small[13],big[1]]]
        sign.lines = lines

        return sign
    }

    func aquarius() -> AstrologicalSign {
        let bezier = UIBezierPath()

        bezier.move(to: CGPointMake(0, 5.4))
        bezier.addCurve(to: CGPointMake(4.5, 5.4), controlPoint1:CGPointMake(3.6, 0), controlPoint2: CGPointMake(8.2, 0))
        bezier.addCurve(to: CGPointMake(12.7, 0), controlPoint1:CGPointMake(11.8, 5.4), controlPoint2: CGPointMake(16.3, 5.4))
        bezier.addCurve(to: CGPointMake(20.8, 5.4), controlPoint1:CGPointMake(19.9, 0), controlPoint2: CGPointMake(24.5, 0))
        bezier.addCurve(to: CGPointMake(29, 0), controlPoint1:CGPointMake(28.1, 5.4), controlPoint2: CGPointMake(32.6, 5.4))
        bezier.addCurve(to: CGPointMake(37.1, 5.4), controlPoint1:CGPointMake(36.2, 0), controlPoint2: CGPointMake(40.7, 0))

        bezier.move(to: CGPointMake(40.7, 15.1))
        bezier.addCurve(to: CGPointMake(36.2, 15.1), controlPoint1:CGPointMake(37.1, 20.5), controlPoint2: CGPointMake(32.6, 20.5))
        bezier.addCurve(to: CGPointMake(28.1, 20.5), controlPoint1:CGPointMake(29, 15.1), controlPoint2: CGPointMake(24.5, 15.1))
        bezier.addCurve(to: CGPointMake(19.9, 15.1), controlPoint1:CGPointMake(20.8, 20.5), controlPoint2: CGPointMake(16.3, 20.5))
        bezier.addCurve(to: CGPointMake(11.8, 20.5), controlPoint1:CGPointMake(12.7, 15.1), controlPoint2: CGPointMake(8.2, 15.1))
        bezier.addCurve(to: CGPointMake(3.6, 15.1), controlPoint1:CGPointMake(4.5, 20.5), controlPoint2: CGPointMake(0, 20.5))

        var sign = AstrologicalSign()
        sign.shape = bezier

        let big = [
            CGPointMake(-140.25,-148.7),
            CGPointMake(-10.75,-203.7),
            CGPointMake(54.25,-158.2),
            CGPointMake(140.25,-127.7)]
        sign.big = big

        let small = [
            CGPointMake(-128.75,-17.7),
            CGPointMake(-93.25,-87.7),
            CGPointMake(-97.75,-135.7),
            CGPointMake(-67.75,-202.2),
            CGPointMake(-53.75,-206.2),
            CGPointMake(-41.75,-193.7),
            CGPointMake(-34.25,-136.2),
            CGPointMake(-18.75,-103.2),
            CGPointMake(-9.75,-85.7)]
        sign.small = small

        let lines = [
            [small[0],small[1]],
            [small[1],small[2]],
            [small[2],big[0]],
            [big[0],small[3]],
            [small[3],small[4]],
            [small[4],small[5]],
            [small[5],big[1]],
            [big[1],big[2]],
            [big[2],big[3]],
            [big[1],small[6]],
            [small[6],small[7]],
            [small[7],small[8]]]
        sign.lines = lines

        return sign
    }

    func sagittarius() -> AstrologicalSign {
        let bezier = UIBezierPath()

        bezier.move(to: CGPointMake(30.4, 10.6))
        bezier.addLine(to: CGPointMake(30.4, 0))
        bezier.addLine(to: CGPointMake(19.8, 0))

        bezier.move(to: CGPointMake(7.8, 10.5))
        bezier.addLine(to: CGPointMake(13.9, 16.5))
        bezier.addLine(to: CGPointMake(0, 30.4))

        bezier.move(to: CGPointMake(30.3, 0.1))
        bezier.addLine(to: CGPointMake(13.9, 16.5))
        bezier.addLine(to: CGPointMake(20, 22.7))

        var sign = AstrologicalSign()
        sign.shape = bezier

        let big = [
            CGPointMake(-69.75,78.3),
            CGPointMake(-98.25,-98.2)]
        sign.big = big

        let small = [
            CGPointMake(0.75,81.8),
            CGPointMake(-18.75,44.3),
            CGPointMake(-102.25,22.3),
            CGPointMake(-109.25,10.8),
            CGPointMake(-142.25,-50.2),
            CGPointMake(-129.75,-62.7),
            CGPointMake(-27.75,-93.7),
            CGPointMake(-10.75,-77.7),
            CGPointMake(-6.25,-112.7),
            CGPointMake(-42.75,-152.2),
            CGPointMake(-57.75,-159.7),
            CGPointMake(-78.75,-171.7),
            CGPointMake(-93.25,-178.7),
            CGPointMake(17.75,-112.7),
            CGPointMake(52.75,-140.7),
            CGPointMake(87.25,-202.7),
            CGPointMake(76.75,-100.2),
            CGPointMake(110.75,-102.7),
            CGPointMake(142.25,-132.7),
            CGPointMake(82.25,-54.2),
            CGPointMake(101.25,-33.7)]
        sign.small = small

        let lines = [
            [small[1],big[0]],
            [small[0],big[0]],
            [big[0],small[2]],
            [small[2],small[3]],
            [small[3],small[4]],
            [small[4],small[5]],
            [small[5],big[1]],
            [big[1],small[6]],
            [small[6],small[9]],
            [small[9],small[10]],
            [small[10],small[11]],
            [small[11],small[12]],
            [small[6],small[8]],
            [small[8],small[13]],
            [small[13],small[14]],
            [small[14],small[15]],
            [small[6],small[7]],
            [small[7],small[13]],
            [small[14],small[16]],
            [small[16],small[17]],
            [small[17],small[18]],
            [small[16],small[19]],
            [small[19],small[20]]]
        sign.lines = lines

        return sign
    }

    func capricorn() -> AstrologicalSign {
        let bezier = UIBezierPath()

        bezier.move(to: CGPointMake(13, 22.3))
        bezier.addLine(to: CGPointMake(13, 6.5))
        bezier.addCurve(to: CGPointMake(13, 2.9), controlPoint1:CGPointMake(10.1, 0), controlPoint2: CGPointMake(6.5, 0))
        bezier.addCurve(to: CGPointMake(2.9, 0), controlPoint1:CGPointMake(0, 2.9), controlPoint2: CGPointMake(0, 6.5))

        bezier.move(to: CGPointMake(13, 6.5))
        bezier.addCurve(to: CGPointMake(13, 2.9), controlPoint1:CGPointMake(15.9, 0), controlPoint2: CGPointMake(19.5, 0))
        bezier.addCurve(to: CGPointMake(23.1, 0), controlPoint1:CGPointMake(26, 2.9), controlPoint2: CGPointMake(26, 6.5))
        bezier.addCurve(to: CGPointMake(26, 16.3), controlPoint1:CGPointMake(27.6, 19.6), controlPoint2: CGPointMake(29.9, 22.9))
        bezier.addCurve(to: CGPointMake(32.2, 26.3), controlPoint1:CGPointMake(35.2, 27.7), controlPoint2: CGPointMake(37.7, 27.7))
        bezier.addCurve(to: CGPointMake(41.8, 27.7), controlPoint1:CGPointMake(45.2, 24.4), controlPoint2: CGPointMake(45.2, 20.3))
        bezier.addCurve(to: CGPointMake(45.2, 16.2), controlPoint1:CGPointMake(41.9, 12.9), controlPoint2: CGPointMake(37.8, 12.9))
        bezier.addCurve(to: CGPointMake(32.1, 12.9), controlPoint1:CGPointMake(30.7, 18.5), controlPoint2: CGPointMake(29.9, 22.9))
        bezier.addCurve(to: CGPointMake(28.3, 31.7), controlPoint1:CGPointMake(22.4, 33.6), controlPoint2: CGPointMake(17.1, 33.6))

        var sign = AstrologicalSign()
        sign.shape = bezier

        let big = [
            CGPointMake(136.25,-41.2),
            CGPointMake(133.25,-9.69999999999999),
            CGPointMake(1.25,50.3),
            CGPointMake(-129.75,73.8),
        ]
        sign.big = big

        let small = [
            CGPointMake(-51.25,59.3),
            CGPointMake(-105.75,72.8),
            CGPointMake(-84.75,103.8),
            CGPointMake(-50.75,122.8),
            CGPointMake(-36.25,128.8),
            CGPointMake(27.75,144.8),
            CGPointMake(81.25,156.8),
            CGPointMake(91.25,133.3)]
        sign.small = small

        let lines = [
            [big[1],big[0]],
            [big[1],big[2]],
            [big[2],small[0]],
            [small[0],small[1]],
            [small[1],big[3]],
            [big[3],small[2]],
            [small[2],small[3]],
            [small[3],small[4]],
            [small[4],small[5]],
            [small[5],small[6]],
            [small[6],small[7]],
            [small[7],big[1]]]
        sign.lines = lines

        return sign
    }

    func scorpio() -> AstrologicalSign {
        let bezier = UIBezierPath()

        bezier.move(to: CGPointMake(10, 24.1))
        bezier.addLine(to: CGPointMake(10, 5))
        bezier.addCurve(to: CGPointMake(10, 2.2), controlPoint1:CGPointMake(7.8, 0), controlPoint2: CGPointMake(5, 0))
        bezier.addCurve(to: CGPointMake(2.2, 0), controlPoint1:CGPointMake(0, 2.2), controlPoint2: CGPointMake(0, 5))

        bezier.move(to: CGPointMake(20, 24.1))
        bezier.addLine(to: CGPointMake(20, 5))
        bezier.addCurve(to: CGPointMake(20, 2.2), controlPoint1:CGPointMake(17.8, 0), controlPoint2: CGPointMake(15, 0))
        bezier.addCurve(to: CGPointMake(12.2, 0), controlPoint1:CGPointMake(10, 2.2), controlPoint2: CGPointMake(10, 5))

        bezier.move(to: CGPointMake(39.1, 31.1))
        bezier.addCurve(to: CGPointMake(36, 28.1), controlPoint1:CGPointMake(30, 23.9), controlPoint2: CGPointMake(30, 15.1))
        bezier.addLine(to: CGPointMake(30, 5))
        bezier.addCurve(to: CGPointMake(30, 2.2), controlPoint1:CGPointMake(27.8, 0), controlPoint2: CGPointMake(25, 0))
        bezier.addCurve(to: CGPointMake(22.2, 0), controlPoint1:CGPointMake(20, 2.2), controlPoint2: CGPointMake(20, 5))

        bezier.move(to: CGPointMake(39.2, 20.5))
        bezier.addLine(to: CGPointMake(39.2, 31.1))
        bezier.addLine(to: CGPointMake(28.6, 31.1))

        var sign = AstrologicalSign()
        sign.shape = bezier

        let big = [
            CGPointMake(-85.75,32.3),
            CGPointMake(-64.75,103.8),
            CGPointMake(38.75,-136.2)]
        sign.big = big

        let small = [
            CGPointMake(-70.75,34.8),
            CGPointMake(-97.75,61.3),
            CGPointMake(-100.75,76.8),
            CGPointMake(-9.25,86.8),
            CGPointMake(28.75,69.8),
            CGPointMake(29.25,54.8),
            CGPointMake(19.75,15.3),
            CGPointMake(10.75,-28.7),
            CGPointMake(24.75,-108.7),
            CGPointMake(56.25,-151.2),
            CGPointMake(103.75,-197.7),
            CGPointMake(81.75,-230.7),
            CGPointMake(61.75,-230.7),
            CGPointMake(119.25,-156.7),
            CGPointMake(130.25,-117.2)]
        sign.small = small

        let lines = [
            [small[0],big[0]],
            [big[0],small[1]],
            [small[1],small[2]],
            [small[2],big[1]],
            [big[1],small[3]],
            [small[3],small[4]],
            [small[4],small[5]],
            [small[5],small[6]],
            [small[6],small[7]],
            [small[7],small[8]],
            [small[8],big[2]],
            [big[2],small[9]],
            [small[9],small[10]],
            [small[10],small[11]],
            [small[11],small[12]],
            [small[10],small[13]],
            [small[13],small[14]]]
        sign.lines = lines
        
        return sign
    }
}
