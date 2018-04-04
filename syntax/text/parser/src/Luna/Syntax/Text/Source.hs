module Luna.Syntax.Text.Source where

import Data.Text.Position (Delta)
import Data.Text32        (Text32)
import Prologue


--------------------
-- === Source === --
--------------------

-- === Definition === --

newtype Source = Source Text32 deriving (Show)
makeLenses ''Source


-- === Instances === --

instance IsString           Source where fromString = convert
instance Convertible String Source where convert    = convertVia @Text32
instance Convertible Text32 Source where convert    = coerce
instance Convertible Source Text32 where convert    = coerce
instance Convertible Source String where convert    = convertVia @Text32