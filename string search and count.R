library(tidyverse)

# using string detect to select identify if any one of a set
# of strings appears in a string

# potential use cases, a list of ICD codes in a single column
#                      a list of proceedure codes in a single column

# want to know if any of my list of disgnosis codes appears in the list
# the string we are looking for could be at any point in the column

codes <- c('ABC dsf df', 
           'ABC dfd fsg', 
           'dfg fds gABC', 
           'ere,rABC,wtr,we', 
           'ewr, ert',
           'dfg | dfg | fsh| ghg| fh',
           'sadfdsfdsfaDEF',
           'fdg sdf gsf dgdfg',
           'dfsg ABCfd gfd ABCfdgfdg',
           'dsf das fABC ABCdfg sdfg DEF')

# turn that into a dataframe
data <- data.frame(codes)

# these are the two codes we are looking for
#      ABC   DEF

# to do this on one code is straight forward
data_filter_single <- data |>
  filter(str_detect(codes, 'ABC'))

# but we can feed an 'or' or | into our str_detect
data_filter_multi <- data |>
  filter(str_detect(codes, 'ABC|DEF'))

# it would be great if we could do this more dynamically
# as this would allow us to get a reference from a different 
# part of our workflow

# lets make a vector of search terms, this could be a result from 
# somewhere else
search_codes <- c ('ABC', 'DEF')

# we now want to make that a single string with '|' between variables
# we can do this with
paste(search_codes, 
      collapse="|")

#lets turn that into a variable
search_multi_codes <- paste(search_codes, 
                            collapse="|")

# we can filter our data to just those that contain our search codes
data_filter_dynamic <- data |>
  filter(str_detect(codes,
                    search_multi_codes))

# we could add a flag to our data if it contains one of these codes
data_flag <- data |>
  mutate(flag = if_else(str_detect(codes, 
                                   search_multi_codes),1,0))

# or we could use str count to count the number of instances
data_count <- data |>
  mutate(count = str_count(codes, 
                           search_multi_codes))

# of sourse the string detect is case sensisitive and may want
# to change to upper or lower to make things easier

