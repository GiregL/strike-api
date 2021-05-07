{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Model.User (User(..), getAllUsers, getUserById) where

------------------------------------------------------------------------------------------------------------------------

import GHC.Generics

import Data.Aeson (ToJSON, FromJSON)
import Database.Constants
import Database.SQLite.Simple
import Control.Monad.Trans.Maybe

import Model.Project(Project(..))
import Control.Monad.Trans.Class (lift)

------------------------------------------------------------------------------------------------------------------------

data User = User
  { id        :: Int
  , username  :: String
  , password  :: String
  , language  :: String
  , email     :: String
  , projects  :: [Project]
  } deriving (Show, Generic)

------------------------------------------------------------------------------------------------------------------------
-- Aeson instances

instance ToJSON User
instance FromJSON User

------------------------------------------------------------------------------------------------------------------------
-- SQLite Simple instances

instance FromRow User where
  fromRow = do
    _id <- field
    _username <- field
    _email <- field
    _password <- field
    return $ User _id _username _password "" _email []


------------------------------------------------------------------------------------------------------------------------
-- Database Management

getAllUsers :: IO [User]
getAllUsers = do
  conn <- databaseConnection
  query_ conn "SELECT * FROM Users" :: IO [User]

getUserById :: Int -> MaybeT IO User
getUserById i = MaybeT $ do
  conn <- databaseConnection
  users <- query conn "SELECT * FROM Users WHERE id = (?)" (Only (show i)) :: IO [User]
  if null users
  then return Nothing
  else return $ Just $ head users