import UIKit

class ViewController: UIViewController {
    @IBOutlet var canvas: UIImageView!
    
    var bruchColor = UIColor.black
    var brushWidth: CGFloat = 10.0
    
    var lastPoint = CGPoint.zero
    var isDrawing = false
    
    var length = 1.0
    
    //
    var locs : [CGPoint] = []
    
    //
    var check_loc1:Bool = true
    var check_loc2:Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func drawLine(from: CGPoint, to: CGPoint){
        UIGraphicsBeginImageContext(canvas.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        canvas.image?.draw(in: canvas.bounds)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(bruchColor.cgColor)
        
        context.move(to: from)
        context.addLine(to: to)
        
        context.strokePath()
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDrawing = false

        // Initialize the path.
        if let touch = touches.first{
            lastPoint = touch.location(in: canvas)
            btnDrawCircle(lastPoint: lastPoint)
            checkLocAndMakePath(loc: lastPoint)
            print("시작 위취 \(lastPoint)")
        }
    }
    
    func btnDrawCircle(lastPoint: CGPoint) {

            //콘텍스트를 이미지뷰 크기와 같게 설정

            UIGraphicsBeginImageContext(canvas.frame.size)

            //생성한 콘텍스트의 정보를 가져온다.

//            let context = UIGraphicsGetCurrentContext()!
//            context.setLineWidth(4.0)
//            context.setStrokeColor(UIColor.blue.cgColor)
//            context.addEllipse(in: CGRect(x:lastPoint.x, y:lastPoint.y, width: 10, height: 10))
//            context.strokePath()
//            context.setLineWidth(5.0)
//            context.setStrokeColor(UIColor.green.cgColor)
//            context.strokePath()
//            canvas.image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
        
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: lastPoint.x, y: lastPoint.y),
                                      radius: CGFloat(20),
                                      startAngle: CGFloat(0),
                                      endAngle: CGFloat(Double.pi * 2),
                                      clockwise: true) //CGPoint(x,y)의 위치가 원의 중심입니다.
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor //you can change the stroke color
        shapeLayer.strokeColor = UIColor.red.cgColor //you can change the line width
        shapeLayer.lineWidth = 3.0
        view.layer.addSublayer(shapeLayer)
        }

    func checkLocAndMakePath(loc: CGPoint){
        
        if locs.count > 4 {
            
            //선도 지우기
            
            // 좌표도 지우
            locs.remove(at: 0)
            locs.remove(at: 0)
        }
        
        
        if check_loc1 && check_loc2 {
            print("check1")
            // 요소 추가하기
            locs.append(loc)
            // 좌표 체크하기
            check_loc1 = false
        }
        else if !check_loc1 && check_loc2 {
            print("check2")
            //1. 선 이어주기
            
            // 배열 마지막 값 불러오기
            var last_loc : CGPoint
            if let last_loc_value = locs.last{
                last_loc = last_loc_value
                let path = UIBezierPath()
                print("last_loc:\(last_loc)")
                print("loc: \(loc)")
                path.move(to: CGPoint(x: last_loc.x, y: last_loc.y))
                path.addLine(to: CGPoint(x: loc.x, y: loc.y))
                path.lineWidth = 2.0
                
                path.close()
                path.stroke()
                print("test")
            }
            // 직선 연결해주기

            // 2. 배열에 저장
            locs.append(loc)
            // 3. 초기화
            check_loc1 = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDrawing = true
        
        if let touch = touches.first{
            let currentPoint = touch.location(in: canvas)
            drawLine(from: lastPoint, to: currentPoint)
            let xDist: CGFloat = (currentPoint.x - lastPoint.x) //[2]
            let yDist: CGFloat  = (currentPoint.y - lastPoint.y) //[3]
            let distance: CGFloat = sqrt((xDist * xDist) + (yDist * yDist))
            print(distance)
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isDrawing{
            drawLine(from: lastPoint, to: lastPoint)
        }
        isDrawing = false
    }
    
}
