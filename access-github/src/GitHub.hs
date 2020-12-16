{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE TypeOperators     #-}

module GitHub where

import Control.Monad (mzero)
import Data.Aeson 
import Data.Proxy 
import Data.Text 
import GHC.Generics 
import Network.HTTP.Client (defaultManagerSettings, newManager)
import Servant.API
import Servant.Client

type GitHubAPI = "testEndpoint" :> Get '[JSON] Text
            :<|> "testEndpoint2" :> Get '[JSON] Text

gitHubAPI :: Proxy GitHubAPI
gitHubAPI = Proxy

testEndpoint :: ClientM Text
testEndpoint2 :: ClientM Text

testEndpoint :<|> testEndpoint2 = client gitHubAPI
