# Exercise-1
# Developed from: http://tidytextmining.com/

# Set up (install packages that you don't have)
library(janeaustenr)
library(tidytext)
library(dplyr)
library(stringr)
library(ggplot2)

# Load books into a dataframe using the austen_books() function
books <- austen_books()

# How many books are in the dataset?
group_by(books, book) %>% distinct() %>% nrow()

# Which book has the most lines?
data.frame(table(books$book)) %>%
  filter(Freq == max(Freq))

# Use the unnest_tokens function to generate the full list of words
words <- unnest_tokens(books, word, text, "words")

# Which words are most common (regardless of which book them come from)?
data.frame(table(words$word)) %>%
  filter(Freq == max(Freq))

# Remove stop words by performing an anti_join with the stop_words dataframe
filtered.words <- anti_join(words, stop_words)

# Which non stop-words are most common?
data.frame(table(filtered.words$word)) %>%
  filter(Freq == max(Freq))

# Use ggplot to make a horizontal bar chart of the word frequencies of non-stop words
ggplot(data = filtered.words) +
  geom_histogram(mapping = aes(x = Var1))
