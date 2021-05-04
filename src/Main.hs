module Main where

import Data.Aeson
import Data.Aeson.Encode.Pretty (encodePretty)
import Text.HTML.Scalpel hiding (matches)
import Data.List.Split
import qualified Data.Map as Map
import Text.RE.TDFA.ByteString.Lazy
import System.Environment (getArgs)

import qualified Data.Text as Text

--------------------------------------------------------------------------------

data Entry = Entry
   { name       :: Text
   , extensions :: Maybe [Text]
   , link       :: Text
   , image      :: Maybe Text
   } deriving (Eq, Show, Generic)
instance ToJSON Entry
instance FromJSON Entry

entries :: TLookup -> Scraper Text [Entry]
entries tl = chroots (AnyTag @: [ hasClass "klitem-tr" ]) $ do
    eName <- text $ AnyTag @: [ hasClass "kltat" ]
    eExt <- texts $ AnyTag @: [ hasClass "klmeta" ]
    eSrc <- attr "href" $ "a"
    eImg <- attr "id" $ "img"
    -- eImg <- attr "src" $ "img"
    let prefix = "https://www.google.com"
    return $ Entry eName (mpack eExt) (prefix <> eSrc) (Map.lookup eImg tl)
    where
    mpack [] = Nothing
    mpack as = Just as

--------------------------------------------------------------------------------
-- This whole section is a terrible hack where I'm extracting the thumbnails
-- from javascript with regular expressions. Ideally we would have run that
-- javascript, and have it modify the DOM, and then extracting the src attribute
-- above would make this whole thing nice and easy, but alas...

type TLookup = Map Text Text

splitScript :: LByteString -> Maybe (Text, Text)
splitScript x = case splitOn "'" (decodeUtf8 x) of
    [dat, _, var,_ ] -> Just (toText var, Text.filter (/='\\') $ toText dat)
    _ -> Nothing

fromScript :: LByteString -> TLookup
fromScript x = Map.fromList $ mapMaybe splitScript $ matches
    $ x *=~ [re|(data:image[^']+)';var ii=\['([^']+)'\]|]

getTLookup :: [LByteString] -> TLookup
getTLookup = fromScript . mconcat
    . filter (\x -> matched $ x ?=~ [re|_setImagesSrc|])

scripts :: Scraper LByteString [LByteString]
scripts = texts "script"

--------------------------------------------------------------------------------

runTest :: FilePath -> FilePath -> IO ()
runTest page expected = do
    mpage <- parsePage page
    mexp <- decodeFileStrict expected
    print $ (==) <$> mexp <*> mpage

parsePage :: FilePath -> IO (Maybe [Entry])
parsePage fpath = do
    f <- readFileLBS fpath
    case getTLookup <$> scrapeStringLike f scripts of
        Just tlookup -> return $ scrapeStringLike (decodeUtf8 f) (entries tlookup)
        Nothing -> return Nothing

main :: IO ()
main = getArgs >>= \case
    [] -> do
        runTest "files/van-gogh-paintings.html" "files/expected-array.json"
        runTest "files/kubrick.html"            "files/kubrick.json"
        runTest "files/dostoevsky.html"         "files/dostoevsky.json"
    (a:_) -> do
        putLBSLn . encodePretty =<< parsePage a

