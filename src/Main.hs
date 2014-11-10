-- {-# LANGUAGE OverloadedStrings #-}

-- import           Control.Applicative
import           Control.Concurrent
import           Control.Monad
import           Control.Monad.Loops
import           Data.IORef
import           Data.Monoid         ((<>))
import           System.Exit
import           System.Random.MWC

gen :: MVar t -> MVar (Maybe String) -> IO ()
gen stop res =
    void $ forkIO $ do
        whileM_ (isEmptyMVar stop) $ do
            v <- withSystemRandom . asGenIO $ \g -> uniformR (1, 5000) g
            if v == (500 :: Int)
                then putMVar res Nothing
                else putMVar res $ Just $ "Thread with value: " <> show v
        print "Got stop command"
        putMVar res Nothing


main :: IO ()
main = do
    cpus <- getNumCapabilities

    let pattern = "TEST"
    print $ "Searching for " <> pattern <> " using " <> show cpus <> " cpus.."

    resVar  <- newEmptyMVar
    stopVar <- newEmptyMVar

    forM_ [1..cpus] $ \_ ->
        forkIO $ gen stopVar resVar

    _ <- forkIO $ do
            threadDelay 1000000
            putMVar stopVar Nothing

    attemptRef <- newIORef (0 :: Integer)
    forever $ do
        res <- takeMVar resVar
        case res of
            Nothing -> print "Done" >> exitSuccess
            Just s -> do
                modifyIORef' attemptRef (+1)
                attempt <- readIORef attemptRef
                when (attempt `mod` 25 == 0) $
                  print $ "Attempt " <> show attempt <> ": " <> s
