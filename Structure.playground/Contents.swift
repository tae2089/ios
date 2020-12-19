import UIKit
//관계가 있는 것들을 묶어서 표현한다
// object = Data + Method
//

struct Location{
    let x:Int
    let y:Int
}
func distance(current: Location,target:Location) -> Double{
    let distanceX = Double(target.x - current.x)
    let distanceY = Double(target.y - current.y)
    let distance = sqrt(distanceX*distanceX+distanceY*distanceY)
    return distance
}


struct Store {
    let loc : Location
    let name : String
    let deliveryRange = 2.0
    
    func isDeliverAble(userLoc: Location) ->Bool{
        let distanceToStore = distance(current: userLoc, target: loc)
        return distanceToStore<2.0
    }
}


let stroe1 = Store(loc:Location(x:3,y:5),name:"gs")
let store2 = Store(loc:Location(x:4,y:6),name:"seven")
let store3 = Store(loc:Location(x:1,y:7),name:"cu")




func printClosesStore(currentLocation:Location,stores:[Store]){
    
    var closestStoreName = ""
    var closestStoreDistance = Double.infinity
    var isDeliverable = false
    
    
    
    for store in stores {
        let distanceToStore = distance(current: currentLocation, target: store.loc)
        closestStoreDistance = min(distanceToStore,closestStoreDistance)
        if closestStoreDistance == distanceToStore{
            closestStoreName = store.name
            isDeliverable = store.isDeliverAble(userLoc: currentLocation)
        }
    }
    
    print("Closest: ",closestStoreName,isDeliverable)
}

let myLocation = Location(x:2,y:5)
let stores = [stroe1,store2,store3]
printClosesStore(currentLocation: myLocation, stores: stores)


struct Lecture: CustomStringConvertible {
    var description: String{
        return "Title: \(lecture_name),Instructor: \(teacher_name)"
    }
    let lecture_name: String
    let teacher_name: String
    let student_num: Int

}


//protocol ->조건 제약
//CustomStringConvertable


func printLecture(instructor:String,lectures:[Lecture]){
    
    for lecture in lectures{
        if instructor == lecture.teacher_name{
            print(lecture)
        }

    }

}


let lec1 = Lecture(lecture_name: "ios basic", teacher_name: "Jason", student_num: 5)
let lec2 = Lecture(lecture_name: "ios Advanced", teacher_name: "Jack", student_num: 5)
let lec3 = Lecture(lecture_name: "ios Pro", teacher_name: "Jim", student_num: 5)

let lectures = [lec1,lec2,lec3]
//printLecture(instructor: "Jim", lectures: lectures)
print(lec1)




struct Person{
    var firstName : String{
        //willSet
        willSet{
            print("didSet: \(firstName) ----> \(newValue)")
        }
        
        //stored property에서만 가능
        didSet {
            print("didSet: \(oldValue) ----> \(firstName)")
        }
    }
    var lastName : String
    
    lazy var isPopular: Bool = {
        if fullName == "Jay Park"{
            return true
        }else{
            return false
        }
    }()
    
    
    //computed property는 stored property를 재가공할 때 사용한다.
    //property는 호출시 값을 하나 반환한다.
    //method 는 호출시 어떤 작업을 한다.
    //
    var fullName: String {
        get{
            return "\(firstName) \(lastName)"
        }
        set{
            if let firstName = newValue.components(separatedBy: " ").first {
                self.firstName = firstName
            }
            if let lastName = newValue.components(separatedBy: " ").last {
                self.lastName = lastName
            }
        }
    }

    
    
    
    //type property
    static let isAlien: Bool = false
}

var person = Person(firstName: "lim", lastName: "taebin")

person.firstName
person.lastName

person.firstName = "Jim"
person.lastName = "Kim"


person.fullName = "Jay Park"
person.fullName

person.firstName
person.lastName

person.isPopular



