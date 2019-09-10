module Datalog exposing (..)

import Dict exposing (Dict)
import Maybe exposing (Maybe)

type Term = Var String | Sym String
type alias Atom = { 
    predSym : String
  , terms : List(Term)
  }
type alias Rule = {
    head : Atom
  , body : List(Atom)
  }

type alias DatalogProgram = List(Rule)

type alias KnowledgeBase = List(Atom)

type alias Substitution = Dict String Term

emptySubstitution : Substitution
emptySubstitution = Dict.empty

substitute : Atom -> Substitution -> Atom
substitute atom substitution =
    let
        go : Term -> Term
        go term = 
            case term of
            Sym sym -> Sym sym
            Var var -> Maybe.withDefault (Var var) (Dict.get var substitution)
    in
        { predSym = ""
        , terms = List.map go atom.terms
        }
  