module IntelBrightness.Core (
    maxBrightness,
    setBrightness
    ) where

readInt :: String -> Int
readInt = read

maxBrightness :: IO Int
maxBrightness = fmap readInt $ readFile "/sys/class/backlight/intel_backlight/max_brightness"

setBrightness :: (Show a) => a -> IO ()
setBrightness nb = writeFile "/sys/class/backlight/intel_backlight/brightness" $ show nb
