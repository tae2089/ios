import UIKit

var evenNumbers: [Int] = [2,4,6,8]
//let evenNumbers2: Array<Int> = [2,4,6,8]
evenNumbers.append(10)
evenNumbers+=[12,14,16]
evenNumbers.append(contentsOf: [18,20])

evenNumbers.count

//print(evenNumbers.first)

if let firstElement = evenNumbers.first{
    print("----> first item is :\(firstElement)" )
}

evenNumbers.max()
evenNumbers.min()

var firstItem = evenNumbers[0]
var secondItem = evenNumbers[1]
var tenthItem = evenNumbers[9]

//var  twentiesItem = evenNumbers[19]

//원하는 위치에 insert
evenNumbers.insert(1, at: 0)
evenNumbers

evenNumbers[0] = -2
evenNumbers

evenNumbers[0...2] = [-2,0,2]
evenNumbers

//evenNumbers.swapAt(0, 9)
evenNumbers

for num in evenNumbers{
    print(num)
}

for(index,num) in evenNumbers.enumerated(){
    print("index:",index,"value:",num)
}

evenNumbers.dropFirst(3)
evenNumbers

//dictionary 연습하기
//[키:값]
var scoreDic: [String:Int] = ["japan":80,"Jay":95,"jake":90]

var scoreDic2: Dictionary<String,Int> = ["japan":80,"Jay":95,"jake":90]

scoreDic["Jay"]
if let score = scoreDic["japan"]{
    score
}else{
    
}

//사용자 추가
scoreDic["jake"] = 100
scoreDic

//사용자 제거
scoreDic["jake"] = nil
scoreDic

//for loop
for (name,score) in scoreDic{
    print(name,score)
}

for key in scoreDic.keys{
    print(key)
}

// 1. 이름 직업 도시에 대해서 본인의 딕셔너리 만들기
// 2.여기서 도시를 부산으로 업데이트 하기
// 3. 딕셔너리를 받아서 이름과 도시 프리트하는 함 수 만들기

var myDic: [String:String] = ["name":"Jason","job":"ios Engineer","city":"Seoul"]
myDic["city"] = "Busan"
myDic

func printNameAndCity(dict:[String:String]){
    if let name = dict["name"], let city = dict["city"]{
        print(name,city)
    }else{
        print("--> cannot find")
    }
}
printNameAndCity(dict: myDic)

//set - 유일한 값들로만 구성되어 있음

var someSet: Set<Int> = [1,2,3,3]
someSet.isEmpty
someSet.count
someSet.contains(1)

//closure
//var multiplyClousure:(Int,Int) ->Int = {a,b in return a*b }
var multiplyClousure:(Int,Int) ->Int = {$0 * $1}
let result = multiplyClousure(4,2)

func opertaeTwonum(a:Int,b:Int, operation:(Int,Int) -> Int) -> Int {
    let  result1 = operation(a,b)
    return result1
}

opertaeTwonum(a: 2, b: 4, operation: multiplyClousure)

opertaeTwonum(a: 2, b: 4){ a,b in
    return b/a
}



let voidClosure: () -> Void = {
    print("ios 개발자 짱, 클로저 어렵넹")
}
voidClosure()

var count = 0
let incrementor = {
    count+=1
}
incrementor()
incrementor()
incrementor()

print(count)

//Example 1: cho Simple Closure
let test = {}


//{(param) -> return type in statement}
//Example2: 코드블록을 구현한 Closure

//let choSimpleClosure = {
//    print("111")
//}

//Example3: 인풋 파라미터를 받는 Closure
//let choSimpleClosure: (String) -> Void = {
//    name in
//    print(name)
//}


//Example4: 값을 리턴하는 Closure
let choSimpleClosure: (String) -> String = {name in
    let message = "IOS 개발 재밌엉\(name)님 경제적 자유를 얻으실 거에요!"
    return message
}
let result2 = choSimpleClosure("코로나 제일 싫어")
result2

//Example5: Closure를 파라미터로 받는 함수 구현
func someSimpleFunction(choSimpleClosure: () -> Void){
    print("함수에서 호출이 되었어요")
    choSimpleClosure()
}
someSimpleFunction(choSimpleClosure: {
    print("test")
})
//finish

