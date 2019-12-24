{-# OPTIONS --cubical #-}

module Cubical.CategoryTheory.Functor where

open import Cubical.Foundations.Prelude
open import Cubical.HITs.PropositionalTruncation
open import Cubical.CategoryTheory.Category

private
  variable
    ℓ𝒞 ℓ𝒟 : Level

record Functor (𝒞 : Precategory ℓ𝒞) (𝒟 : Precategory ℓ𝒟) : Type (ℓ-max ℓ𝒞 ℓ𝒟) where
  no-eta-equality
  open Precategory

  field
    F-ob : 𝒞 .ob → 𝒟 .ob
    F-hom : {x y : 𝒞 .ob} → 𝒞 .hom x y → 𝒟 .hom (F-ob x) (F-ob y)
    F-idn : {x : 𝒞 .ob} → F-hom (𝒞 .idn x) ≡ 𝒟 .idn (F-ob x)
    F-seq : {x y z : 𝒞 .ob} (f : 𝒞 .hom x y) (g : 𝒞 .hom y z) → F-hom (𝒞 .seq f g) ≡ 𝒟 .seq (F-hom f) (F-hom g)

  is-full = (x y : _) (F[f] : 𝒟 .hom (F-ob x) (F-ob y)) → ∥ Σ (𝒞 .hom x y) (λ f → F-hom f ≡ F[f]) ∥
  is-faithful = (x y : _) (f g : 𝒞 .hom x y) → F-hom f ≡ F-hom g → f ≡ g
