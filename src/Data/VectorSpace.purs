-- Copyright 2016 Morgan Thomas
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

module Data.VectorSpace where

import Data.Group (class Group)
import Data.Field (class Field)
import Data.Monoid.Additive (Additive(..))
import Data.Ring (mul)

-- | A `VectorSpace` v over a field f of "scalars" is a type with an
-- | addition operation <> which makes v a `Group`, and a scalar multiplication
-- | operation `scalarMul` for multiplying a vector by a scalar.
-- |
-- | In addition to the relevant `Group` and `Field` laws, a `VectorSpace` must
-- | satisfy the following laws:
-- |
-- | ```text
-- | x `scalarMul` (y `scalarMul` v) = (x * y) `scalarMul` v
-- | one `scalarMul` v = v
-- | x `scalarMul` (u <> v) = (x `scalarMul` u) <> (x `scalarMul` v)
-- | (x + y) `scalarMul` u = (x `scalarMul` u) <> (y `scalarMul` v)
-- | ```
class (Group v, Field f) <= VectorSpace v f | v -> f where
  scalarMul :: f -> v -> v

infixr 6 scalarMul as *<

instance numberVectorSpace :: VectorSpace (Additive Number) Number where
  scalarMul x (Additive y) = Additive (x `mul` y)
