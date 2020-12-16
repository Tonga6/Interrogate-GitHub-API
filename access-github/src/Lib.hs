module Lib
    ( someFunc
    ) where

import GitHub

someFunc :: IO ()
someFunc = do
    putStrLn "Executing sampleGitHubCall:"
    sampleGitHubCall
    putStrLn "end."

sampleGitHubCall :: IO ()
sampleGitHubCall  = do putStrLn "Placeholder for GitHubCall"