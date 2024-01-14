{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeApplications      #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE TypeOperators         #-}

module AlwaysSucceeds.TypedValidator(
  validator
  )where

import Plutus.Script.Utils.Scripts (Validator, mkValidatorScript)
import PlutusLedgerApi.V2.Contexts (ScriptContext)
import PlutusTx qualified
import PlutusTx.Prelude (Bool (True), BuiltinData, Integer, check)


myTypedValidator :: Integer -> Integer -> ScriptContext -> Bool
myTypedValidator _ _ _ = True

untypedValidator :: BuiltinData -> BuiltinData -> BuiltinData -> ()
untypedValidator datum redeemer ctx =
  check (
  myTypedValidator
    (PlutusTx.unsafeFromBuiltinData datum)
    (PlutusTx.unsafeFromBuiltinData redeemer)
    (PlutusTx.unsafeFromBuiltinData ctx)
  )
validator :: Validator
validator = mkValidatorScript $$(PlutusTx.compile [||untypedValidator||])
