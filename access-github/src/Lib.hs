{-# LANGUAGE FlexibleContexts     #-}
{-# LANGUAGE DataKinds            #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE DuplicateRecordFields     #-}

module Lib
    ( someFunc
    ) where

import qualified GitHub as GH
import qualified Servant.Client as SC
import Network.HTTP.Client (newManager)
import Network.HTTP.Client.TLS (tlsManagerSettings)

import Data.Text hiding (map,intercalate)
import Data.List (intercalate)
someFunc :: IO ()
someFunc = do
    putStrLn "Executing getUserInfo:"
    getUserInfo
    putStrLn "Executing getRepoLanguage:"
    -- getRepoLanguage

getUserInfo :: IO ()
getUserInfo  = 
  (SC.runClientM (GH.getUser (Just "haskell-app") "Tonga6") =<< env) >>= \case

    Left err -> do
      putStrLn $ "Error encountered: " ++ show err
    Right res -> do
      putStrLn $ "Returned val: " ++ show res

      (SC.runClientM (GH.getRepoLanguage (Just "haskell-app") "Tonga6" "College") =<< env) >>= \case

        Left err -> do
          putStrLn $ "Error encountered: " ++ show err
        Right res -> do
          putStrLn $ "Returned val: " ++ show res


  where env :: IO SC.ClientEnv
        env = do
          manager <- newManager tlsManagerSettings
          return $ SC.mkClientEnv manager (SC.BaseUrl SC.Http "api.github.com" 80 "")