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
let terminer = taskManager.places.filter{$0.name == "terminer"}[0]


    print("Exercie 3 : tire conduisant au problème")
//j'ai repris la méthode vu en exercie que je trouvais plus pratique
//je crée donc mon marquage de départ dans la variable m
//ne pas ce soucier de la place "terminer" qui est faite pour empécher le problème
var m: PTMarking = [taskPool: 0, processPool: 0, inProgress: 0, terminer: 10]
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

print("TEST foncitonnement classique")
var m1: PTMarking = [taskPool: 0, processPool: 0, inProgress: 0, terminer: 1]
//puis je tire les transitions une à une dans une boucle
for t in [create, spawn, exec, success] {
    m1 = t.fire(from: m1)!

//pour voir le résultat de chaque tire, on imprime le résultats à chaque fin de boucle
    print("Etape", t, m1)
}


let correctTaskManager = createCorrectTaskManager()


print("---------------------------------------")
print("Exercice 4 : correction du problème")

//comme dans la première fonction
let ycreate = taskManager.transitions.filter{$0.name == "create"}[0]
let yspawn = taskManager.transitions.filter{$0.name == "spawn"}[0]
let yexec = taskManager.transitions.filter{$0.name == "exec"}[0]
let ysuccess = taskManager.transitions.filter{$0.name == "success"}[0]
let yfail = taskManager.transitions.filter{$0.name == "fail"}[0]
let ytaskPool = taskManager.places.filter{$0.name == "taskPool"}[0]
let yprocessPool = taskManager.places.filter{$0.name == "processPool"}[0]
let yinProgress = taskManager.places.filter{$0.name == "inProgress"}[0]
let yterminer = taskManager.places.filter{$0.name == "terminer"}[0]

//On a ajouter une place "terminer", voir les liens dans TaskManagerLib
//pour que le reseau soit tirable : on met terminer à 1
var m2: PTMarking = [taskPool: 0, processPool: 0, inProgress: 0, terminer: 1]
//puis je tire les transitions une à une dans une boucle, ici j'essaie de finir sur un Fail, tout fonctionne parfaitement
for t in [ycreate, yspawn, yexec, yfail] {
    m2 = t.fire(from: m2)!

//pour voir le résultat de chaque tire, on imprime le résultats à chaque fin de boucle
    print("Etape", t, m2)
}

print("----------------------------------")
print("TEST mise en echec")

var m3: PTMarking = [taskPool: 0, processPool: 0, inProgress: 0, terminer: 1]
//puis je tire les transitions une à une dans une boucle
for t in [ycreate, yspawn, yspawn, yexec, yexec, ysuccess] {
    m3 = t.fire(from: m3)!

//pour voir le résultat de chaque tire, on imprime le résultats à chaque fin de boucle
    print("Etape", t, m3)
}
//le resultat est un crash car le réseau n'est pas tirable avec ces tirs
print("----------------------------------")
