import UIKit
import Foundation
// ------- while
//while 조건{}
// code
//}

//var i = 0
//while i < 10{
//    print(i)
//    i+=1
//}
//var i = 0
//while i < 10{
//    print(i)
//    if i == 5{
//        break
//    }
//    i+=1
//}


//while
// 조건 > 코드 수행 > 조건 > 코드 수행
//
//repeat while
// 코드 수행 > 조건 > 코드 수행 > 조건

// ------ For Loop
//let closedRangee = 0...10
//let halfClosedRange = 0..<10
//
//var sum = 0
//for i in closedRangee{
//    print("--- \(i)")
//    sum+=i
//}
//print("total sum: \(sum)")
//
//var sineValue: CGFloat = 0
//for i in closedRangee{
//    sineValue=sin(CGFloat.pi/4 * CGFloat(i))
//}
//
//for i in closedRangee where i % 2 == 0{
//
//}



let num = 10

switch num {
case 0:
    print("---> 0이에여")
case 10:
    print("----> 10입니다.")
default:
    print("그 외 숫자입니다.")
}




let coordinate = (x:20,y:20)

//switch coordinate {
//case (0,0):
//    print("원점이네여")
//case (_,0):
//    print("x축 이네여")
//case (0,_):
//    print("y축 이네여")
//default:
//    print("좌표 어딘가")
//}

switch coordinate {
case (0,0):
    print("원점이네여")
case (let x,0):
    print("x축 이네여 x: \(x)")
case (0,let y):
    print("y축 이네여 y: \(y)")
case (let x, let y) where x == y:
    print("x,y is same x,y: \(x),\(y)")
case (let x, let y):
    print("좌표 어딘가 x,y: \(x),\(y)")

}
