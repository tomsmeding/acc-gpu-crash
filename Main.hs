{-# LANGUAGE FlexibleInstances #-}
module Main where

-- import qualified Data.Array.Accelerate as A
-- import qualified Data.Array.Accelerate.Interpreter as I
import qualified Data.Array.Accelerate.LLVM.PTX as GPU
-- import System.Exit

-- import N1
import N2


-- fDifferent :: Float -> Float -> Bool
-- fDifferent a b = abs (a - b) > 0.2

-- class Different a where
--     different :: a -> a -> Bool

-- instance A.Shape sh => Different (A.Array sh Float) where
--     different a b = or (zipWith fDifferent (A.toList a) (A.toList b))

-- instance Different () where
--     different () () = False

-- instance (Different a, Different b) => Different (a, b) where
--     different (a, b) (x, y) = different a x || different b y

main :: IO ()
main = do
    -- let res1 = I.run program2
    let res2 = GPU.run program2

    length (show res2) `seq` return ()

    -- if different res1 res2
    --     then do putStrLn "Noooo!"
    --             print res1
    --             print res2
    --             exitFailure
    --     else return ()
