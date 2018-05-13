{-# LANGUAGE Strict               #-}
{-# LANGUAGE UndecidableInstances #-}

module Data.Graph.Component.Node.Layer.Model where

import Prologue

import qualified Data.Construction               as Data
import qualified Data.Graph.Component.Edge.Class as Edge
import qualified Data.Graph.Component.Node.Class as Node
import qualified Data.Graph.Data.Layer.Class     as Layer
import qualified Data.Graph.Data.Layer.Layout    as Layout

import Data.Graph.Component.Edge.Class (SomeEdge)
import Data.Graph.Component.Node.Class (Node)
import Data.Graph.Data.Layer.Class     (Layer)



-------------------
-- === Model === --
-------------------

-- === Definition === --

data Model deriving (Generic)
instance Data.ShallowDestructor1 IO Node.Uni => Layer Model where
    type Cons  Model        = Node.Uni
    type View  Model layout = Node.TagToCons (Layout.Get Model layout)
    manager = Layer.unsafeOnlyDestructorManager


-- === Utils === --

model :: Layer.ViewReader Node Model layout m
      => Node layout -> m (Layer.ViewData Model layout)
model = Layer.readView @Model ; {-# INLINE model #-}

inputs :: ( Layer.Reader Node Model m
          , Layer.IsUnwrapped Node.Uni
          , Edge.Provider1    Node.Uni
          , MonadIO m
          ) => Node layout -> m [SomeEdge]
inputs = Edge.edges1 <=< Layer.read @Model ; {-# INLINE inputs #-}


-- === Instances === --

instance (Node.IsUni t, Layer.IsUnwrapped Node.Uni)
      => Layer.IsCons1 Model t where
    cons1 = Node.toUni ; {-# INLINE cons1 #-}