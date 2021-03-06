public class MarkingGraph {

    public typealias Marking = [String: Int]

    public let marking   : Marking
    public var successors: [String: MarkingGraph]

    public init(marking: Marking, successors: [String: MarkingGraph] = [:]) {
        self.marking    = marking
        self.successors = successors
    }

}


func countNodes(markingGraph: MarkingGraph) -> Int {
  //algo de recherche en profondeur
  //seen (marquage deja vu)
  //toVisit (marquage à visiter)
  var seen = [markingGraph]
  var toVisit = [markingGraph]

  while let current = toVisit.popLast() { //on met le premier markingGraph sur une pile, qu'on depile
    for (_, successor) in current.successors { //le _ sert à dire qu'on ne veut pas specifier de variable pour le nom de la transition
      if !seen.contains(where: {$0 === successor}) {//si j'ai pas vu encore contains
        seen.append(successor) //on l'ajoute
        toVisit.append(successor) //on l'ajoute pour le visiter encore
      }
    }
  }

  return seen.count
}


// Ex. 1: Mutual exclusion - Graphe de marquage 1.3
do {
    let m0 = MarkingGraph(marking: ["p0": 1, "p1": 0, "p2": 1, "p3": 0, "p4": 1])
    let m1 = MarkingGraph(marking: ["p0": 0, "p1": 1, "p2": 0, "p3": 0, "p4": 1])
    let m2 = MarkingGraph(marking: ["p0": 1, "p1": 0, "p2": 0, "p3": 1, "p4": 0])

    m0.successors = ["t1": m1, "t3": m2]
    m1.successors = ["t0": m0]
    m2.successors = ["t2": m0]
}

// Ex. 2: PetriNet 1
do {
    let m0 = MarkingGraph(marking: ["p0": 2, "p1": 0])
    let m1 = MarkingGraph(marking: ["p0": 1, "p1": 1])
    let m2 = MarkingGraph(marking: ["p0": 0, "p1": 2])

    m0.successors = ["t0": m1]
    m1.successors = ["t0": m2, "t1": m0]
    m2.successors = ["t1": m1]

    // Write your code here ...
}

// Ex. 2: PetriNet 2
do {
    let m0 = MarkingGraph(marking: ["p0": 1, "p1": 0, "p2": 0, "p3": 0, "p4": 0])
    let m1 = MarkingGraph(marking: ["p0": 0, "p1": 1, "p2": 0, "p3": 1, "p4": 0])
    let m2 = MarkingGraph(marking: ["p0": 0, "p1": 0, "p2": 1, "p3": 1, "p4": 0])
    let m3 = MarkingGraph(marking: ["p0": 0, "p1": 1, "p2": 0, "p3": 0, "p4": 1])
    let m4 = MarkingGraph(marking: ["p0": 0, "p1": 0, "p2": 0, "p3": 1, "p4": 0])
    let m5 = MarkingGraph(marking: ["p0": 0, "p1": 0, "p2": 1, "p3": 0, "p4": 1])
    let m6 = MarkingGraph(marking: ["p0": 0, "p1": 1, "p2": 0, "p3": 0, "p4": 0])
    let m7 = MarkingGraph(marking: ["p0": 0, "p1": 0, "p2": 0, "p3": 0, "p4": 1])
    let m8 = MarkingGraph(marking: ["p0": 0, "p1": 0, "p2": 1, "p3": 0, "p4": 0])
    let m9 = MarkingGraph(marking: ["p0": 0, "p1": 0, "p2": 0, "p3": 0, "p4": 0])

    m0.successors = ["t0": m1]
    m1.successors = ["t1": m2, "t3": m3]
    m2.successors = ["t2": m4, "t3": m5]
    m3.successors = ["t1": m5, "t4": m6]
    m4.successors = ["t3": m7]
    m5.successors = ["t2": m7, "t4": m8]
    m6.successors = ["t1": m8]
    m7.successors = ["t4": m9]
    m8.successors = ["t2": m9]

    // Write your code here ...
}

// Ex. 2: PetriNet 3
do {
    let m0 = MarkingGraph(marking: ["p0": 0, "p1": 2])
    let m1 = MarkingGraph(marking: ["p0": 1, "p1": 1])
    let m2 = MarkingGraph(marking: ["p0": 2, "p1": 0])

    m0.successors = ["t1": m1]
    m1.successors = ["t0": m1, "t1": m2]
    m2.successors = ["t2": m0]

    // Write your code here ...
}
