import TaskManagerLib
import PetriKit

let taskManager = createTaskManager()

let create = taskManager.transitions.filter{$0.name == "create"}[0]
let spawn = taskManager.transitions.filter{$0.name == "spawn"}[0]
let exec = taskManager.transitions.filter{$0.name == "exec"}[0]
let success = taskManager.transitions.filter{$0.name == "success"}[0]
let fail = taskManager.transitions.filter{$0.name == "fail"}[0]
let taskPool = taskManager.places.filter{$0.name == "taskPool"}[0]
let processPool = taskManager.places.filter{$0.name == "processPool"}[0]
let inProgress = taskManager.places.filter{$0.name == "inProgress"}[0]

// Show here an example of sequence that leads to the described problem.
// For instance:

var m: PTMarking = [taskPool: 0, processPool: 0, inProgress: 0]
for t in [create, spawn, spawn, exec, exec, success, create, spawn, spawn, exec, exec, success] {
    m = t.fire(from: m)!

    print("Etape", t, m)
  }
  print("On a donc bien un proccessus qui n'est pas détruit avec cette execution")


    //let m1 = create.fire(from: [taskPool: 0, processPool: 0, inProgress: 0])
    //let m2 = spawn.fire(from: m1!)

    //print(m1)
//     ...

let correctTaskManager = createCorrectTaskManager()

// Show here that you corrected the problem.
// For instance:
//     let m1 = create.fire(from: [taskPool: 0, processPool: 0, inProgress: 0])
//     let m2 = spawn.fire(from: m1!)
//     ...
