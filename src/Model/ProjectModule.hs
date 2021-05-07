{-# LANGUAGE DeriveGeneric #-}

module Model.ProjectModule where

------------------------------------------------------------------------------------------------------------------------

import Model.Date

import GHC.Generics

import Data.Aeson (FromJSON, ToJSON)

------------------------------------------------------------------------------------------------------------------------

-- Project module
data ProjectModule = ProjectModule ModuleKind ModuleTemporalKind
  deriving (Show, Generic)

-- Kind of the project module
data ModuleKind
  = Economical      -- A money goal to achieve
  deriving (Show, Generic)

-- Temporal strategy of the project module
data ModuleTemporalKind
  = Recurrent Date TimeStamp        -- Repeat the module kind
  | Milestone Date                  -- Happens one time only
  deriving (Show, Generic)

------------------------------------------------------------------------------------------------------------------------

instance FromJSON ProjectModule
instance ToJSON ProjectModule

instance FromJSON ModuleKind
instance ToJSON ModuleKind

instance FromJSON ModuleTemporalKind
instance ToJSON ModuleTemporalKind