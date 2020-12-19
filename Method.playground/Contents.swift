import UIKit

struct Lecture{
    
    var title: String
    var maxStudents: Int = 10
    var numOfRegistered: Int = 0
    
    func remainSeats() -> Int {
        let remainSeats = self.maxStudents - self.numOfRegistered
        return remainSeats
    }
    
    //stored property를 변경할 경우 method는 mutating을 사용해야 함
    mutating func register(){
        numOfRegistered += 1
    }
    
    static let targe: String = "Anybody want to leearn something"
    
    static func 소속학원이름() -> String{
        return "패캠"
    }
    
}

var lec = Lecture(title: "ios Basic",numOfRegistered: 5)

lec.remainSeats()
lec.register()
lec.register()
lec.remainSeats()




var value: Int = 3
extension Int {
    func square() -> Int{
        return self*self
    }
}

value.square()


struct Math {
  static func abc(a:Int) -> Int{
        if a < 0{
            return -a
        }else{
            return a
        }
        
    }
}

Math.abc(a:15)

extension Math {
    static func square(value: Int) -> Int {
        return value * value
    }
}

Math.square(value: 10)
