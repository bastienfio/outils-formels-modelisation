import ProofKitLib

let a: Formula = "a"
let b: Formula = "b"
let f = !(a && b)
print(f)
//version NNF de f
print("la forme nnf de \(f) est \(f.nnf)")


//proofkit revoit des paretnhèse entre chaque terme parfois inutile


let c: Formula = "c"
//formule ex9 2.1
let f2 = !(a && (b || c))
print("2.1 ex9")
print("la forme nnf de \(f2) est \(f2.nnf)")
print("cnf de f2 = \((!a || !b) && (!a || !c))")
print("dnf de f2 = f2.nnf : \(f2.nnf)")

//formule ex9 2.2
let f3 = (a => b) || !(a && c)
print("2.2 ex9")
print("la forme nnf de \(f3) est \(f3.nnf)")
print("cnf = nnf de f3 = \(!a || b || !c)")
print("dnf = cnf de f3 = \(!a || b || !c)")
//dnf de f2 = f2.nnf

//formule ex9 2.3
print("2.3 ex9")
let f4 = ((!a || b && c) && a)
print("la forme nnf de \(f4) est \(f4.nnf)")
print("cnf de f4 = \(b && c && a)")
print("dnf = cnf de f4 = \(b && c && a)")

let booleanEvaluation = f.eval { (proposition) -> Bool in
    switch proposition {
        case "p": return true
        case "q": return false
        default : return false
    }
}
print(booleanEvaluation)

enum Fruit: BooleanAlgebra {

    case apple, orange

    static prefix func !(operand: Fruit) -> Fruit {
        switch operand {
        case .apple : return .orange
        case .orange: return .apple
        }
    }

    static func ||(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.orange, .orange): return .orange
        case (_ , _)           : return .apple
        }
    }

    static func &&(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.apple , .apple): return .apple
        case (_, _)           : return .orange
        }
    }

}

let fruityEvaluation = f.eval { (proposition) -> Fruit in
    switch proposition {
        case "p": return .apple
        case "q": return .orange
        default : return .orange
    }
}
print(fruityEvaluation)
