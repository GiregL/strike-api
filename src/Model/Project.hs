{-# LANGUAGE DeriveGeneric #-}

module Model.Project where

------------------------------------------------------------------------------------------------------------------------

import GHC.Generics

import Data.Aeson (FromJSON, ToJSON)

import Model.ProjectModule

------------------------------------------------------------------------------------------------------------------------

data Project = Project
  { title       :: String
  , description :: String
  , dueDate     :: String
  , fromDate    :: String
  , modules     :: [ProjectModule]
  }
  deriving (Show, Generic)

------------------------------------------------------------------------------------------------------------------------

instance ToJSON Project
instance FromJSON Project