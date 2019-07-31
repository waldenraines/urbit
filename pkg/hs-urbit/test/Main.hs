module Main (main) where

import ClassyPrelude

import Test.QuickCheck       hiding ((.&.))
import Test.Tasty
import Test.Tasty.QuickCheck
import Test.Tasty.TH

import System.Environment (setEnv)

import qualified LogTests
import qualified DeriveNounTests
import qualified ArvoTests
import qualified AmesTests

main :: IO ()
main = do
  setEnv "TASTY_NUM_THREADS" "1"
  defaultMain $ testGroup "Urbit"
    [ LogTests.tests
    , DeriveNounTests.tests
    , ArvoTests.tests
    , AmesTests.tests
    ]