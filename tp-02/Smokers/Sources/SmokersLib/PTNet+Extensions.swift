import PetriKit

public class MarkingGraph {

    public let marking   : PTMarking
    public var successors: [PTTransition: MarkingGraph]

    public init(marking: PTMarking, successors: [PTTransition: MarkingGraph] = [:]) {
        self.marking    = marking
        self.successors = successors
    }

}


public func NombreMarquage(input:MarkingGraph) -> Int {

      var Visiter : [MarkingGraph] = []
      var Avisiter : [MarkingGraph] = [input]

      while let current = Avisiter.popLast() {
        Visiter.append(current)
        for (_, successors) in current.successors {
          //comme vu dans l'ex 5, on compare les pointeur
          if !Visiter.contains(where: { $0 === successors }) {
            Avisiter.append(successors)
          }
        }
      }
      return Visiter.count
    }


public extension PTNet {

    public func markingGraph(from marking: PTMarking) -> MarkingGraph? {
        // Write here the implementation of the marking graph generation.
        //Marquage initial
        let m0 = MarkingGraph(marking: marking)
        //il faut créer la liste des noeuds à visiter et des noeuds visité
        var noeudAvisiter : [MarkingGraph] = [m0]
        var noeudVisiter : [MarkingGraph] = []

        //Création de la boucle qui va visiter tout les noeuds jusqu'à la liste vide
        while(!noeudAvisiter.isEmpty) {
          //variable prenant la valeur su noeud visité
          let progress = noeudAvisiter.remove(at:0)
          //on enlève le noeud de la liste à visiter et on l'ajoute dans visité
          noeudVisiter.append(progress)

          //Il faut utilisé toute les transitions possibles du graphe : création d'une boucle
          for i in transitions{
            if let tirProgress = i.fire(from: progress.marking){
              if let noeudDejaVisiter = noeudVisiter.first(where: {$0.marking == tirProgress}){
                progress.successors[i] = noeudDejaVisiter
              }
              else{
                let current = MarkingGraph(marking: tirProgress)
                progress.successors[i] = current
                if (!noeudAvisiter.contains(where: {$0.marking == current.marking})){
                  noeudAvisiter.append(current)
                }
              }
            }
          }
        }
        return m0
    }
}
