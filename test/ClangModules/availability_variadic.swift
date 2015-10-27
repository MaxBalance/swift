// RUN: %target-swift-frontend(mock-sdk: %clang-importer-sdk) -parse -verify -I %S/Inputs/custom-modules %s

import cfuncs

func variadicFunc2(A : Int32, _: Any...) -> Int { return 0 }

class C1 {}

func test_unavailable_because_variadic() {
  print(variadicFunc1(2, [3])) // expected-error {{'variadicFunc1' is unavailable: Variadic function is unavailable}}
  print(variadicFunc1(2, [3], C1())) // expected-error {{'variadicFunc1' is unavailable: Variadic function is unavailable}}
  print(variadicFunc1(2, 3, 3, 4)) // expected-error {{'variadicFunc1' is unavailable: Variadic function is unavailable}}
  print(variadicFunc1(2, 3, [3], 4)) // expected-error {{'variadicFunc1' is unavailable: Variadic function is unavailable}}
  print(variadicFunc2(2, [3])) // no-error
  print(variadicFunc2(2, 3)) // no-error
  print(variadicFunc2(2, 3, C1())) // no-error
  print(variadicFunc2(2, 3, 4, 5, 6)) // no-error
  print(variadicFunc2(2, [3], [4], 5, 6)) // no-error
}
