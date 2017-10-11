import TaskManagerLib
import PetriKit

let taskManager = createTaskManager()

//création des variables correspondant aux transitions et aux places
let create = taskManager.transitions.filter{$0.name == "create"}[0]
let spawn = taskManager.transitions.filter{$0.name == "spawn"}[0]
let exec = taskManager.transitions.filter{$0.name == "exec"}[0]
let success = taskManager.transitions.filter{$0.name == "success"}[0]
let fail = taskManager.transitions.filter{$0.name == "fail"}[0]
let taskPool = taskManager.places.filter{$0.name == "taskPool"}[0]
let processPool = taskManager.places.filter{$0.name == "processPool"}[0]
let inProgress = taskManager.places.filter{$0.name == "inProgress"}[0]

//j'ai repris la méthode vu en exercie que je trouvais plus pratique
//je crée donc mon marquage de départ dans la variable m
var m: PTMarking = [taskPool: 0, processPool: 0, inProgress: 0]
//puis je tire les transitions une à une dans une boucle
for t in [create, spawn, spawn, exec, exec, success, create, spawn, spawn, exec, exec, success] {
    m = t.fire(from: m)!

//pour voir le résultat de chaque tire, on imprime le résultats à chaque fin de boucle
    print("Etape", t, m)
  }
  print("On a donc bien un proccessus qui n'est pas détruit avec cette execution")

  //A la fin de la première execution (premier success), on voit qu'il reste un processus bloqué dans le inProgress
  //pour être sur je relance une fois la même execution, et on voit qu'il y en a maintenant deux.
  //Les processus ne sont donc pas détruit avec cette execution


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
