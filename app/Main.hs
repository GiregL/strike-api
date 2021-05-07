{-# LANGUAGE OverloadedStrings #-}

module Main where

------------------------------------------------------------------------------------------------------------------------

import Web.Scotty

import Data.Monoid

import Data.Aeson (encode, decode)

import Model.Project (Project(..))
import Model.User (User(..), getAllUsers, getUserById)
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Trans.Maybe
import Database.Migrations

import Database.SQLite.Simple
import Control.Monad.Trans.Class (lift)

------------------------------------------------------------------------------------------------------------------------

lille :: Project
lille = Project "Lille" "Reprendre les études à Lille" "01/09/2022" "19/12/2020" []

lezenn :: User
lezenn = User 1 "Lezenn" "123123" "fr_FR" "lezenns@gmail.com" [lille]

userList :: [User]
userList = [lezenn]

------------------------------------------------------------------------------------------------------------------------

getAllUsers :: ActionM ()
getAllUsers = do
  users <- liftIO Model.User.getAllUsers
  json users

getUserById :: ActionM ()
getUserById = do
  userIdS <- param "id"
  let userId = read userIdS :: Int
  maybeUser <- lift $ runMaybeT $ Model.User.getUserById userId
  case maybeUser of
    Nothing -> json ([] :: [User])
    Just u  -> json u

getAllProjectsOfUserId :: ActionM ()
getAllProjectsOfUserId = do
  userIdS <- param "id"
  let userId = read userIdS :: Int
  let result = filter (\user -> Model.User.id user == userId) userList
  json $ map Model.User.projects result

--main2 :: IO ()
--main2 = scotty 3000 $ do
--  get "/users" getAllUsers
--  get "/users/:id" getUserById
--  get "/projects/:id" getAllProjectsOfUserId

------------------------------------------------------------------------------------------------------------------------
-- Main

main :: IO ()
main = do
  migrate
  scotty 3000 $ do
    get "/users" Main.getAllUsers
    get "/users/:id" Main.getUserById