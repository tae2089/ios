import UIKit

var carName: String?
carName = nil
carName = "tank"

//아주 간단한 예제
var actorName: String?
actorName = "서현진"

let num = Int("10")

// 고급 기능 4가지
// Forced unwrapping -> 억지로 박스 열기 -> !를 사용해서 한다
print(carName!)

// Optional binding (if let) -> 부드럽게 박스를 열기 1
carName = nil

if let unwrappedCarName = carName{
    print(unwrappedCarName)
}else{
    print("Car Name 없다.")
}

func printParsedInt(from: String){
    
    if let parsedInt = Int(from){
        print(parsedInt)
    }else{
        print("Int로 컨버팅 안된다.")
    }
}

printParsedInt(from: "100")
printParsedInt(from: "hello")

// Optional binding (guard) -> 부드럽게 박스를 열기 2


func printParsedInt1(from: String){
    
    guard let parsedInt = Int(from) else{
        print("Int로 컨버팅 안된다.")
        return
    }
    print(parsedInt)
}


printParsedInt1(from: "100")
printParsedInt1(from: "hello")

// Nil coalescing -> 박스를 열어보니, 없으면 default값을 준다.

let myCarName: String = carName ?? "모델 5"

var foodName: String? = "떡볶이"

print(foodName!)
if let name = foodName{
    print(name)
}else{
    print("not exist")
}

func printNickName(name:String?){
    guard let nickname = name else{
        print("nick name 만들어보기")
        return
    }
    print(nickname)
}

printNickName(name: "hello")
printNickName(name: nil)
