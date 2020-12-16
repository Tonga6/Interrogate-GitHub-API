module GitHub where

import Control.Monad (mzero)
import Data.Aeson 
import Data.Proxy 
import Data.Text 
import GHC.Generics 
import Network.HTTP.Client (defaultManagerSettings, newManager)
import Servant.API
import Servant.Client
testFunc :: IO ()
testFunc = putStrLn "someFunc"