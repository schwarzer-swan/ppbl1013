module Main where

import AlwaysSucceeds.Compiler (writeAlwaysSucceedsScript, writeTypedAlwaysSucceedsScript)

main :: IO ()
main = do
  e <- writeAlwaysSucceedsScript
  e' <- writeTypedAlwaysSucceedsScript
  case (e , e') of
   (Right _, Right _) -> pure ()
   (a, a') ->  print a *> print a' *> fail "write has failed" -- not pretty, but works
