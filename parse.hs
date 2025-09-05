module Parse where

import Data.Char
import Data.List
import Text.Read

-- Simple parser for job IDs
-- This module provides functions to parse and validate job IDs

-- Job ID type
type JobID = String

-- Parse a job ID from a string
parseJobID :: String -> Maybe JobID
parseJobID str = 
    let cleaned = filter isAlphaNum str
    in if length cleaned >= 3 && length cleaned <= 20
       then Just cleaned
       else Nothing

-- Validate if a string is a valid job ID
isValidJobID :: String -> Bool
isValidJobID str = case parseJobID str of
    Just _  -> True
    Nothing -> False

-- Extract job IDs from a list of strings
extractJobIDs :: [String] -> [JobID]
extractJobIDs = mapMaybe parseJobID

-- Parse job IDs from a text with various separators
parseJobIDsFromText :: String -> [JobID]
parseJobIDsFromText text = 
    let words = words text
        candidates = concatMap (splitOnSeparators) words
    in extractJobIDs candidates
    where
        splitOnSeparators :: String -> [String]
        splitOnSeparators str = 
            let separators = [',', ';', '|', '\t', '\n']
            in foldl (\acc sep -> concatMap (splitOn sep) acc) [str] separators
        
        splitOn :: Char -> String -> [String]
        splitOn _ [] = []
        splitOn sep str = 
            let (before, after) = break (== sep) str
            in before : case after of
                [] -> []
                (_:rest) -> splitOn sep rest

-- Main function for testing
main :: IO ()
main = do
    putStrLn "Job ID Parser"
    putStrLn "============="
    
    let testInputs = ["JOB123", "job-456", "INVALID", "ABC123DEF", "job,123;456|789"]
    
    putStrLn "\nTesting individual job ID parsing:"
    mapM_ (\input -> 
        putStrLn $ input ++ " -> " ++ show (parseJobID input)
    ) testInputs
    
    putStrLn "\nTesting job ID extraction from text:"
    let textInput = "JOB123, job-456; INVALID | ABC123DEF"
    let extracted = parseJobIDsFromText textInput
    putStrLn $ "Input: " ++ textInput
    putStrLn $ "Extracted: " ++ show extracted
