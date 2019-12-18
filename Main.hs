import IntelBrightness.Core
import Data.Maybe (Maybe(..))
import System.Environment
import System.Console.ArgParser ( Descr(..)
                                , reqPos
                                , parsedBy
                                , andBy
                                , optFlagArgs
                                , withParseResult
                                )
import System.Console.ArgParser.BaseType (ParserSpec)

percentOf :: (Real a, Real b) => a -> b -> Double
percentOf p x = (pd / 100.0) * xd
    where pd = realToFrac p
          xd = realToFrac x

data Config =
    Config (Maybe String) Float
    deriving (Show)

configParser :: ParserSpec Config
configParser = Config
    `parsedBy` optFlagArgs Nothing "device" Nothing overwrite
    `andBy` reqPos "percentage" where
        overwrite :: forall m a. (Applicative m) => m a -> a -> m a
        overwrite _ v = pure v

main' :: Config -> IO ()
main' (Config devicePath desiredPercent) = do
    args <- getArgs
    mb <- maxBrightness devicePath'
    let newBrightness = round $ desiredPercent `percentOf` mb in do
        putStrLn $ "Setting brightness to " ++ (show newBrightness) ++ "/" ++ (show mb)
        setBrightness devicePath' newBrightness
        putStrLn $ "Brightness set to " ++ show desiredPercent ++ "%"
    where
        devicePath' =
            case devicePath of
              Just v -> v
              Nothing -> "/sys/class/backlight/intel_backlight"

main = withParseResult configParser main'
