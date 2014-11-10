{-# LANGUAGE OverloadedStrings #-}

import Test.Tasty
import Test.Tasty.Hspec
import OnionAddress

import Data.Text (Text)
import qualified Data.Text as T
-- import Data.List
-- import Data.Ord

main :: IO ()
main = do
  tree <- testSpec "HSpec tsts" hspecTests
  defaultMain tree

targetAddr :: OnionAddress
targetAddr =  OnionAddress "egsluwnygzik5pim"

privateKey :: PrivKey
privateKey =
  PrivKey
  . T.unlines
  $ [ "-----BEGIN RSA PRIVATE KEY-----"
    , "MIICXwIBAAKBgQDLCUoxCXuPTkrXsLlp2iSaMXCEUE4Q3ddIqM3vqptJJDGtQUNq"
    , "sZ6Y6QtkIp/SNk3PFJpWOIEyYRvxVvbVCS5nH/ewc+cA8HWz5GUTZVLlK6nVzVEn"
    , "5qWWUHtBGMCf4r3puY/KvbiO/6WMvXiAJ3NitkJuvBk/okfogOKiIj7c7wIDAQAB"
    , "AoGBAIFpTmyrCqJw2KtZ7RRXAnV1ha4QMXH2tD2PupNEPu4Dr9YqfvoGdHwqLiSJ"
    , "HS0zh6yyCR1jrpWZ5+GP+IwY6gWWZj/eeTqC/SyweP7YTCkgkrWebTQUurTi5FyZ"
    , "CSH5vSkapKajU3KPRvdqW0AI+Xhs0pGsBkvKa8o2Yyg1lsOBAkEA4OzZIcz5Zf+H"
    , "To09ISgmS3TmCE3CrHkg6rU4Zjnltfeq9xChonxqaHLwrqYdEwFNSk/wParWax6Q"
    , "Ga7msYO6nwJBAOcWRnZ/j36MuqJPeDj4XEznKiewf4TZz9gyiUPPcSFIWSNXRLWW"
    , "RPtBLc9php+zWyAhqxfwNsLemSGfdJcaC7ECQQDaRv+wvaqKQaCdqpNYSg5fy+Iw"
    , "zMXPev1myNci3az/GorfmVRCy1q4YlMQKkSs3OaU517Neaz7530Qb5uRSbUhAkEA"
    , "3u5mW7sDu5oYEq2H1a4DnU0FJfTnkEpwcKmQMpLVGL6q/6UY6/Vj5uAiSY4MCdUF"
    , "fCH+5MEgky4bnIwv9fVygQJBALYqF32XTdDBxVj/Mt2yQG7qT6wThjHXMUptK9DS"
    , "5TVLMw/rFJuVi5l8miydQRPTyXCnOkQHlWCFUJu10V2MIRc="
    , "-----END RSA PRIVATE KEY-----"
    ]

hspecTests :: Spec
hspecTests = do
  describe "Generating onion addresses" $ do
    it "creates addresses correctly given a private key" $ do
      shouldBe (mkOnionAddress privateKey) targetAddr
