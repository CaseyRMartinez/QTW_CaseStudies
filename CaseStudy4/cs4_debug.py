from pandas import Series, DataFrame
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pandas_datareader import data as web
from dateutil.parser import parse
from pyfinance.ols import PandasRollingOLS
from datetime import datetime
pd.options.display.max_rows = 12
np.set_printoptions(precision=4, suppress=True)

## First I am going to replicate the analysis, then change things up
price = web.get_data_yahoo('SPY')['Adj Close'] * 10

expires = {'ESU2': datetime(2012, 9, 21),
           'ESZ2': datetime(2012, 12, 21)}

expires = Series(expires).sort_values()

np.random.seed(12347)
N = 200
walk = (np.random.randint(0, 200, size=N) - 100) * 0.25
perturb = (np.random.randint(0, 20, size=N) - 10) *0.25
walk = walk.cumsum()

rng = pd.date_range(price.index[0], periods=len(price) + N, freq='B')
near = np.concatenate([price.values, price.values[-1] + walk])
far = np.concatenate([price.values, price.values[-1] + walk + perturb])
prices = DataFrame({'ESU2': near, 'ESZ2': far}, index=rng)

def get_roll_weights(start, expiry, items, roll_periods=5):
    # start : first date to compute weighting DataFrame
    # expiry : Series of ticker -> expiration dates
    # items : sequence of contract names

    dates = pd.date_range(start, expiry[-1], freq='B')
    weights = DataFrame(np.zeros((len(dates), len(items))),
                        index=dates, columns=items)

    prev_date = weights[0]
    for i, (item, ex_date) in enumerate(expiry.iteritems()):
        if i < len(expiry) - 1:
            weights.iloc[prev_date:ex_date - pd.offsets.BDay(), item] = 1
            roll_rng = pd.date_range(end=ex_date - pd.offsets.BDay(),
                                     periods=roll_periods + 1, freq='B')

            decay_weights = np.linspace(0, 1, roll_periods + 1)
            weights.iloc[roll_rng, item] = 1 - decay_weights
            weights.iloc[roll_rng, expiry.index.get_loc[i + 1]] = decay_weights
        else:
            weights.iloc[prev_date:, item] = 1

        prev_date = ex_date

    return weights

rweights = get_roll_weights('6/1/2012', expires, prices.columns)