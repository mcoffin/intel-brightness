import IntelBrightness.Core
import System.Environment

percentOf :: (Real a, Real b) => a -> b -> Double
percentOf p x = (pd / 100.0) * xd
    where pd = realToFrac p
          xd = realToFrac x

main = do
    args <- getArgs
    mb <- maxBrightness
    let desiredPercent = read . head $ args :: Double
    let newBrightness = round $ desiredPercent `percentOf` mb in do
        putStrLn $ "Setting brightness to " ++ (show newBrightness) ++ "/" ++ (show mb)
        setBrightness newBrightness
