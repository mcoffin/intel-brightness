module IntelBrightness.Core (
    maxBrightness,
    setBrightness
    ) where

readInt :: String -> Int
readInt = read

maxBrightness :: String -> IO Int
maxBrightness = fmap readInt . readFile . flip (++) "/max_brightness"

setBrightness :: (Show a) => String -> a -> IO ()
setBrightness path nb = writeFile (path ++ "/brightness") $ show nb
