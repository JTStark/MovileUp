//: Playground - noun: a place where people can play

import UIKit



func impar(num: Int) -> Bool {
    //return num % 2 != 1
    
    if(num % 2 == 1){
        return true
    }
    else {
        return false
    }
}

impar(2)
impar(1996)
impar(1851)



func fatorial(num: Int) -> Int {
    if(num == 0){
        return 1
    }
    
    return num * fatorial(num - 1)
}

fatorial(0)
fatorial(3)
fatorial(4)



func minMax(nums: [Int]) -> (Int, Int)? {
    if (nums == []){
        return nil;
    }
    
    var (min, max) = (nums[0], nums[0]) //= (Int.max, Int.min)
    
    for aux in nums{
        if aux < min {
            min = aux
        }
        if aux > max {
            max = aux
        }
    }
    
    return (min, max)
}

minMax([])
minMax([2, 0, -1])



func busca(vet: [Int], trgt: Int) -> Int? {
    
    for (index, aux) in enumerate(vet){
        if aux == trgt{
            return index
        }
    }
    
    return nil
}

busca([1, 0 , 5 , 10], 8)
busca([1, 0 , 5 , 10], 5)



//extension string para usar como vetor
func palindromo(palavra: String) -> Bool {
    var len = count(palavra)
    var flag = true
    
    var vet = Array(palavra.unicodeScalars)
    
    for var i = 0; (i < len/2) && (flag); i++ {
        if vet[i] != vet[len - i - 1]{
            flag = false
        }
    }
    
    return flag
}

palindromo("arara")
palindromo("sabiá")
palindromo("a baba baba")



func impares(nums: [Int]) -> [Int] {
    return nums.filter(impar)
    
//    var res: [Int] = []
//    
//    for x in nums {
//        if impar(x) {
//            res.append(x)
//        }
//    }
//    
//    return res
}

impares([])
impares([0, 2, 4])
impares([1, 2 , 3 , 5])
impares([1, 2, 1, 5])





enum Jogadas {
    case Pedra
    case Papel
    case Tesoura
}

enum Resultado {
    case Vitoria
    case Empate
    case Derrota
}

func jokenpo(player1: Jogadas, player2: Jogadas) -> Resultado {
    switch (player1, player2){
        case let (x, y) where x == y:
            return .Empate
        
        case (.Pedra, .Tesoura), (.Tesoura, .Papel), (.Papel, .Pedra):
            return .Vitoria
        
        default:
            return .Derrota
    }
}

jokenpo(.Pedra, .Pedra)
jokenpo(.Pedra, .Papel)
jokenpo(.Pedra, .Tesoura)



















func teste() -> Void{
    
    var firstForLoop = 0
    for i in 0..<4 {        firstForLoop += i    }    println(firstForLoop)    
    var secondForLoop = 0    for var i = 0; i < 4; ++i {        secondForLoop += i    }    println(secondForLoop)
}


