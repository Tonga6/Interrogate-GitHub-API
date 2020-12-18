{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE TypeOperators     #-}
{-# LANGUAGE DuplicateRecordFields     #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE FlexibleContexts #-}

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
type Repository = Text
type UserAgent = Text
type Commits = Text

data GitHubUser =
    GitHubUser {    login   :: Maybe Text,
                    name    :: Maybe Text,
                    email   :: Maybe Text}
                    deriving (Generic, FromJSON, Show)

data GitHubRepo =
  GitHubRepo { name :: Text
             } deriving (Generic, FromJSON, Show)

data GitHubLanguage =
    GitHubLanguage {   language   :: Text}
                        deriving (Generic, FromJSON, Show)

data GitHubCommits =
    GitHubCommits {     commits   :: Maybe Text}
                        deriving (Generic, FromJSON, Show)

type GitHubAPI = "users" :> Header "user-agent" UserAgent 
                         :> Capture "username" Username  :> Get '[JSON] GitHubUser

            :<|> "users" :> Header  "user-agent" UserAgent 
                        :> Capture "username" Username  :> "repos" :>  Get '[JSON] [GitHubRepo]

            :<|> "repos" :> Header "user-agent" UserAgent 
                         :> Capture "username" Username
                         :> Capture "repo" Repository  :> Get '[JSON] GitHubLanguage
                         
            :<|> "repos" :> Header "user-agent" UserAgent 
                         :> Capture "username" Username
                         :> Capture "repo" Repository :> Get '[JSON] GitHubCommits
            
                         
gitHubAPI :: Proxy GitHubAPI
gitHubAPI = Proxy

getUser :: Maybe UserAgent -> Username -> ClientM GitHubUser
getUserRepos :: Maybe UserAgent -> Username -> ClientM [GitHubRepo]
getRepoLanguage :: Maybe UserAgent -> Username -> Repository -> ClientM GitHubLanguage
getRepoCommits :: Maybe UserAgent -> Username -> Repository ->ClientM GitHubCommits

getUser :<|> getUserRepos :<|> getRepoLanguage :<|> getRepoCommits = client gitHubAPI
