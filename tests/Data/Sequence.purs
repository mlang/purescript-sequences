module Tests.Data.Sequence where

import Data.Monoid
import Data.Maybe
import Debug.Trace
import Test.QuickCheck

import qualified Data.Sequence as S
import qualified Data.FingerTree as FT

instance arbSeq :: (Arbitrary a) => Arbitrary (S.Seq a) where
  arbitrary = S.fromArray <$> arbitrary

sequenceTests = do
  trace "Test semigroup law: associativity"
  quickCheck $ \x y z -> (x <> y) <> z == x <> (y <> z :: S.Seq Number)
    <?> ("x: " <> show x <> ", y: " <> show y <> ", z:" <> show z)

  trace "Test monoid law: left identity"
  quickCheck $ \x -> (mempty <> x) == (x :: S.Seq Number)
    <?> ("x: " <> show x)

  trace "Test monoid law: right identity"
  quickCheck $ \x -> (x <> mempty) == (x :: S.Seq Number)
    <?> ("x: " <> show x)
