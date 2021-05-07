{-# LANGUAGE DeriveGeneric #-}

module Model.Date where

------------------------------------------------------------------------------------------------------------------------

import GHC.Generics

import Data.Aeson (FromJSON, ToJSON)

------------------------------------------------------------------------------------------------------------------------

data Date = Date
  { day   :: Int
  , month :: Int
  , year  :: Int
  }
  deriving (Show, Generic)

data TimeStamp
  = Days Int
  | Months Int
  | Years Int
  deriving (Show, Generic)

------------------------------------------------------------------------------------------------------------------------

instance FromJSON Date
instance ToJSON Date

instance FromJSON TimeStamp
instance ToJSON TimeStamp