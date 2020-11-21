import UIKit

//var str = "Hello, playground"
//
//let coordinate = (4,6)
//
//let x = coordinate.0
//let y = coordinate.1
//
//let coordinateNamed = (x:2,y:3)
//
//let x2 = coordinateNamed.x
//let y2 = coordinateNamed.y
//
//let(x3,y3) = coordinateNamed
//x2
//x3
//
//let yes = true
//let no = false
//
//let isFour = 4>6
//
//if isFour{
//    print("4가 크다")
//}else{
//    print("false")
//}
// 논리 연산자


let name1 = "Jin"
let name2 = "Json"

let isTwoNameSame = name1 == name2

if isTwoNameSame{
    print("same name")
}else{
    print("different name")
}

let isJson = name2 == "JsonSong"

let isMale = true

let jasonAndMale = isJson && isMale
let jsonOrMale = isJson || isMale


let greetingMessage: String = isJson ? "hello jason" : "hello sombody"

//if isJson{
//    greetingMessage = "Hello Jason"
//}else{
//    greetingMessage = "hello Somebody"
//}

print("message: \(greetingMessage)")


var hours = 50
var payPerhour = 10000
var salary = 0

if hours > 40 {
    //extraHours = 조건문 안에서 설정되어 기에 사용할 수 없음
    let extraHours = hours - 40
    salary += extraHours * payPerhour * 2
    hours -= extraHours
}

salary += hours*payPerhour
salary
