module OnionAddress where

import qualified Codec.Binary.Base32 as Base32
import qualified Crypto.Hash.SHA1 as SHA1
import qualified Crypto.Types.PubKey.DSA as DSA
import Data.ASN1.Encoding (encodeASN1', decodeASN1')
import Data.ASN1.BinaryEncoding
import Data.ASN1.Types
import Data.PEM
import qualified Data.X509 as X509
import qualified Data.ByteString     as B
import           Data.Text           (Text)
import qualified Data.Text.Encoding  as T

newtype OnionAddress = OnionAddress Text deriving (Show, Eq)

-- TODO: fork and patch crypto-pubkey to parse
-- rsa private key blocks?
-- mkOnionAddress :: PublicKey -> OnionAddress
-- mkOnionAddress pubKey =
--   OnionAddress . T.decodeUtf8
--                . Base32.encode
--                . B.take 10
--                . SHA1.hash
--                . (\bs -> encodeASN1' DER [OctetString bs])
--                . T.encodeUtf8
--                . ?
--                $ pubKey

-- -- Modified from readKeyFile in x509-store.  Put it somewhere else?
-- parseRSAprivate :: PEM -> Maybe X509.PrivKey
-- parseRSAprivate pem =
--   case decodeASN1' BER (pemContent pem) of
--         Left _     -> Nothing
--         Right asn1 -> case pemName pem of
--                         "RSA PRIVATE KEY" -> tryRSA asn1
--                         _                 -> Nothing
--   where
--     tryRSA asn1 = case fromASN1 asn1 of
--             Left _      -> Nothing
--             Right (k,_) -> Just $ X509.PrivKeyRSA k

