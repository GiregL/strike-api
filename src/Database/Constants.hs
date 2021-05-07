module Database.Constants where

import Database.SQLite.Simple

------------------------------------------------------------------------------------------------------------------------
-- Database Constants

database :: String
database = "strike.db"

databaseConnection :: IO Connection
databaseConnection = open database