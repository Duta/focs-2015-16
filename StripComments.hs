module StripComments where

import Control.Applicative ((<$>), (<*>))
import System.Environment (getArgs)
import Text.ParserCombinators.Parsec

main :: IO ()
main = do
  args <- getArgs
  case args of
    [inputPath, outputPath] -> stripComments inputPath outputPath
    _ -> putStrLn "USAGE: StripComments inputPath outputPath"

stripComments :: FilePath -> FilePath -> IO ()
stripComments inputPath outputPath = do
  inputFile <- readFile inputPath
  case parse noComments inputPath inputFile of
    Left e -> putStrLn "Parse error:" >> print e
    Right strippedFile -> writeFile outputPath strippedFile

whiteSpace :: Parser ()
whiteSpace = skipMany multiLineComment

multiLineComment :: Parser ()
multiLineComment = do
  try $ string "(*"
  inCommentMulti

inCommentMulti :: Parser ()
inCommentMulti
    =   do {try $ string "*)";        return ()}
    <|> do {multiLineComment;         inCommentMulti}
    <|> do {skipMany1 $ noneOf "(*)"; inCommentMulti}
    <|> do {oneOf "(*)";              inCommentMulti}

noComments :: Parser String
noComments = whiteSpace >> nonCommentChars
  where
    nonCommentStartingLeftParen = do
      char '('
      notFollowedBy $ char '*'
      return '('
    singleCharacter = nonCommentStartingLeftParen <|> anyToken
    nonCommentChars = (:) <$> singleCharacter <*> noComments
                  <|> (eof >> return "")
