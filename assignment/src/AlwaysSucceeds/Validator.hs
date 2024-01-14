{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}

module AlwaysSucceeds.Validator (
  validator
  ) where
import Plutus.Script.Utils.Scripts (Validator, mkValidatorScript)
import PlutusTx (BuiltinData, compile)

myValidator :: BuiltinData -> BuiltinData -> BuiltinData -> ()
myValidator _ _ _ = ()

validator :: Validator
validator = mkValidatorScript $$(compile [||myValidator ||])
