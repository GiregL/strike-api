{-# LANGUAGE OverloadedStrings #-}

module Database.Migrations where

import Database.SQLite.Simple
import System.Directory
import System.IO

import Database.Constants

------------------------------------------------------------------------------------------------------------------------
-- Migration management

locker :: String
locker = "migrated.lock"

checkMigrationDone :: IO Bool
checkMigrationDone = doesFileExist locker

migrate :: IO ()
migrate = do
  exists <- checkMigrationDone
  if exists
  then return ()
  else do
    sequence_ migrations

    h <- openFile locker ReadWriteMode
    hPutStrLn h "migrated" >> hFlush h
    hClose h
    putStrLn "Migrated the database."

------------------------------------------------------------------------------------------------------------------------
-- Table Creations

migrations :: [IO ()]
migrations =
  [ createUsersTable
  ]

createUsersTable :: IO ()
createUsersTable = do
  conn <- databaseConnection
  _ <- execute_ conn "CREATE TABLE Users(\
  \ id INTEGER PRIMARY KEY,\
  \ username VARCHAR(255) NOT NULL,\
  \ email VARCHAR(255) UNIQUE NOT NULL,\
  \ password VARCHAR(255) NOT NULL\
  \)"
  return ()