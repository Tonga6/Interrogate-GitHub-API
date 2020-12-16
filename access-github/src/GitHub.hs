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

type Username = Text
type UserAgent = Text

type GitHubAPI = "users" :> Header "user-agent" UserAgent 
                         :> Capture "username" Username  :> Get '[JSON] Text
            :<|> "test2" :> Get '[JSON] Text
gitHubAPI :: Proxy GitHubAPI
gitHubAPI = Proxy

testEndpoint :: Maybe UserAgent -> Username -> ClientM Text
testEndpoint2 :: ClientM Text

testEndpoint :<|> testEndpoint2 = client gitHubAPI
