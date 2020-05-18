import pandas as pd


def matchGenre(genre:str):
  imdb_dt = pd.read_csv('imdb_df_subset.csv')
  imdb_dt = imdb_dt[imdb_dt['genres']==genre]
  imdb_dt = imdb_dt.sort_values(by='weightedAverage', ascending=False)
  movielist = imdb_dt.primaryTitle.to_numpy()
  if len(movielist)>10:
    movielist = movielist[0:10]
  return movielist

def matchYear(yr:int):
  imdb_dt = pd.read_csv('imdb_df_subset.csv')
  imdb_dt = imdb_dt[imdb_dt['startYear']==yr]
  imdb_dt = imdb_dt.sort_values(by='weightedAverage', ascending=False)
  movielist2 = imdb_dt.primaryTitle.to_numpy()
  if len(movielist2)>10:
    movielist2 = movielist2[0:10]
  return movielist2
