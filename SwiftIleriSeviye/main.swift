//
//  main.swift
//  SwiftIleriSeviye
//
//  Created by Mustafa Emir Ata on 15.11.2025.
//

import Foundation

//struct  - kalıtım kullkanılamaz -Zstack
//class ->heap
let mustafa=UserClass(isim: "Mustafa Emir", yas: 20, meslek: "Öğrenci")
print(mustafa.isim)

let mustafaStruct=UserStruct(isim: "Mustafa Emir", yas: 20, meslek: "Öğrenci")
print(mustafaStruct.meslek)

// tuple

var benimTuple=(10,20)
print(benimTuple.0)

var benimTuple2=(40,50,88)
benimTuple2.2=50
print(benimTuple2)

let benimTuple3=("mustafa",44)
print(benimTuple3.0)

let benimTuple4=("emir",[1,2,3,4])
print(benimTuple4.1[2])

// Guard Let

// -> if lettekinin tersi olarak olmadığı durumda yapılacaklar belirtilir.

let numaraString="Mustafa"
Int(numaraString)

func inteCevirenIfLetFonk(string:String) ->Int{
    if let benimInteger=Int(string){
        return benimInteger
    }else{
        return 0
    }
}
print(inteCevirenIfLetFonk(string: numaraString))

func inteCevirenGuarLet(string:String) ->Int{
    guard let benimInteger = Int(string) else {
        return 0
    }
    return benimInteger
}
print(inteCevirenGuarLet(string: numaraString))

//Breakpoint

var sayi=5
print(sayi)

sayi=sayi+1
print(sayi)

