-- Statisch getypeerd: De compiler kent de types van variabelen en functies tijdens het compileren

-- Definieer een functie die de som van twee getallen berekent
addNumbers : Int -> Int -> Int
addNumbers x y =
    x + y

-- Probeer de functie aan te roepen met een String in plaats van een Int
-- Dit resulteert in een compileerfout
-- Uncomment de volgende regel om de fout te zien
-- invalidSum = addNumbers 5 "10"

-- Sterk getypeerd: Variabelen en functies hebben een vastgesteld type en de compiler handhaaft dit

-- Definieer een type genaamd "Person" met velden voor naam en leeftijd
type alias Person =
    { name : String
    , age : Int
    }

greet : Person -> String
greet person =
    "Hallo, " ++ person.name ++ "! Je bent " ++ String.fromInt person.age ++ " jaar oud."

-- Maak een voorbeeldpersoon met een naam en leeftijd
examplePerson : Person
examplePerson =
    { name = "Alice"
    , age = 25
    }

-- Probeer de begroetingsfunctie aan te roepen met een getal in plaats van een persoon
-- Dit resulteert in een compileerfout
-- Uncomment de volgende regel om de fout te zien
-- invalidGreeting = greet 42