import UIKit


// 구조체는 Value Types 클래스는 Reference Types이다

struct PersonStruct{
    var firstName: String
    var lastName: String

    var fullName: String {
        return "\(firstName) \(lastName)"
    }


    mutating func uppercaseName() -> Void {
        firstName = firstName.uppercased()
        lastName = lastName.uppercased()
    }

}

class PersonClass {
    var firstName: String
    var lastName: String

    init(firstName: String,lastName:String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }


    func uppercaseName() -> Void {
        firstName = firstName.uppercased()
        lastName = lastName.uppercased()
    }
}
var personStruct1 = PersonStruct(firstName: "Jason", lastName: "Lee")
var personStruct2 = personStruct1

var personClass1 = PersonClass(firstName: "Jason", lastName: "Lee")
var personClass2 = personClass1

personStruct2.firstName = "Jay"
personStruct1.firstName
personStruct2.firstName

personClass2.firstName = "Jay"
personClass1.firstName
personClass2.firstName

personClass2 = PersonClass(firstName: "Bob", lastName: "Lee")
personClass1.firstName
personClass2.firstName

//struct를 사용할 떄
//1. object를 비굑할때
//2. Copy된 각 객체들이 독립적인 상황을 가져야 할 경우
//3. 코드에서 오브젝트의 데이터를 여러 스레드에 걸쳐 사용할 경우

// class를 사용할 떄
//1. 두 object의 인스턴스 자체가 같음을 확인해야 할때
//2. 하나의 객체가 필요하고, 여러 대상에 의해 접근되고 변경이 필요한 경우

struct Grade{
    var letter: Character
    var points: Double
    var credits: Double
}

class Person {
    var firstName: String
    var lastName: String

    init(firstName: String,lastName:String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    convenience init(firstName: String) {
        self.init(firstName:firstName,lastName:"")
    }
    
    func printMyName() {
        print(firstName,lastName)
    }
}


class Student: Person {
    var grades: [Grade] = []
    init(firstName: String, lastName: String,grades:[Grade]) {
        self.grades = grades
        super.init(firstName: firstName, lastName: lastName)
    }
}

let grade1 = Grade(letter: "A", points: 1.5, credits: 1.5)

let grades = [grade1]
let student1 = Student(firstName: "Jay", lastName: "Lee",grades: grades)
student1.firstName
student1.lastName
student1.grades

class StudentAthlate: Student {
    var minimumTraingTime: Int = 2
    var trainTime: Int = 0
    
    func train(){
        trainTime += 1
    }
}


class FootballPlayer: StudentAthlate {
    var footballTeam = "Fc Swift"
    
    override func train() {
        trainTime += 2
    }
}


var athlete1 = StudentAthlate(firstName: "yuna", lastName: "kim", grades: grades)
var athelete2 = FootballPlayer(firstName: "heung", lastName: "Son", grades: grades)

athlete1.minimumTraingTime
athelete2.minimumTraingTime

athelete2.footballTeam
athelete2.train()
athelete2.trainTime
athelete2.train()
athelete2.trainTime

//upper casting
athlete1 = athelete2 as StudentAthlate
athlete1.train()
athlete1.trainTime

//down casting
if let son = athlete1 as? FootballPlayer {
    print("--> team: \(son.footballTeam)")
}
