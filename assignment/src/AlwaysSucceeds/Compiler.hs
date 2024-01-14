-- |
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications  #-}

module AlwaysSucceeds.Compiler(
   writeAlwaysSucceedsScript,
   writeTypedAlwaysSucceedsScript
  ) where

import Cardano.Api qualified as C
import Cardano.Api.Shelley (PlutusScript (..))
import Codec.Serialise (serialise)
import Data.ByteString.Lazy qualified as LBS
import Data.ByteString.Short qualified as SBS
import Plutus.Script.Utils.Scripts (Validator, unValidatorScript)
import PlutusLedgerApi.V2 qualified as Plutus.V2
import PlutusTx.Prelude
import Prelude (FilePath, IO)

import AlwaysSucceeds.TypedValidator qualified
import AlwaysSucceeds.Validator qualified

writeValidator :: FilePath -> Validator -> IO (Either (C.FileError ()) ())
writeValidator file
  = C.writeFileTextEnvelope @(PlutusScript C.PlutusScriptV2) (C.File file) Nothing
  . PlutusScriptSerialised
  . SBS.toShort
  . LBS.toStrict
  . serialise
  . unValidatorScript

writeAlwaysSucceedsScript :: IO (Either (C.FileError ()) ())
writeAlwaysSucceedsScript = writeValidator "output/always-succeeds.plutus" AlwaysSucceeds.Validator.validator

writeTypedAlwaysSucceedsScript :: IO (Either (C.FileError ()) ())
writeTypedAlwaysSucceedsScript
  = writeValidator "output/typed-always-succeeds.plutus" AlwaysSucceeds.TypedValidator.validator
