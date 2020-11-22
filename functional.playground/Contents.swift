import UIKit

func printName(){
    print("-----> My Name is Taebin")
}
printName()

// param 1개
//숫자를 받아서 10을 곱해서 출력한다.

func printMultipleOfTen(value:Int){
    print("\(value) * 10 = \(value * 10)")
}

printMultipleOfTen(value: 10)

//param 2개
//물건값과 갯수를 받아서 전체 금액을 출력하는 함수
//func printTotalPrice(price:Int,count:Int){
//    print("Total Price \(price*count)")
//}
//printTotalPrice(price: 1500, count: 5)


//func printTotalPrice(가격 price:Int,갯수 count:Int){
//    print("Total Price \(price*count)")
//}
//
//printTotalPrice(가격: 1500, 갯수: 5)

func printTotalPrice(_ price:Int,_ count:Int){
    print("Total Price \(price*count)")
}

printTotalPrice( 1500, 5)


func printTotalPriceWithDefaultValue(price: Int = 1500, count: Int){
    print("Total Price: \(price*count)")
}

printTotalPriceWithDefaultValue(count: 5)
printTotalPriceWithDefaultValue(count: 7)
printTotalPriceWithDefaultValue(price:2000,count: 7)

func TotalPriceReturn(price:Int,count:Int) -> Int {
    
    return price * count
}
var a = TotalPriceReturn(price: 10, count: 5)
a

func printFistNameAndSecondName(firstName: String, lastName: String){
    print("----> \(firstName)\(lastName)")
}

func printFistNameAndSecondNameNo(_ firstName: String,_ lastName: String){
    print("----> \(firstName)\(lastName)")
}

func printFistNameAndSecondNameReturn(firstName: String, lastName: String) -> String{
    return firstName + lastName
    //return "\(firstName) \(lastName)"
}

printFistNameAndSecondName(firstName: "lim", lastName: "taebin")
printFistNameAndSecondNameNo("lim", "taebin")
var fullname = printFistNameAndSecondNameReturn(firstName: "lim", lastName: "taebin")




//overload
func printTotalPrice(price:Int, count:Int){
    print("Total Price \(price*count)")
}
func printTotalPrice(price:Double, count: Double){
    print("Total Price \(price*count)")
}

//in out param
var value = 3
func incrementAndPrint(_ value:inout Int){
    value+=1
    print(value)
}
incrementAndPrint(&value)


func add(_ a:Int, _ b:Int) -> Int{
    return a+b
}
func minus(_ a: Int, _ b:Int) -> Int {
    return a-b
}
//변수에 함수 넣어주기
var function = add
function(4,2)

function = minus
function(4,2)

func printResult(_ function:(Int,Int) -> Int ,_ a:Int,_ b:Int){
    let result = function(a,b)
    print(result)
}
printResult(add, 10, 5)

