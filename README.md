coupling
========

Matlab and Python scripts for calculating functional coupling between time series data.


I've created this repository to store some super-basic 'function' codes that I've written to allow for the estimation of dynamic functional coupling between timeseries. In short, the function takes timeseries data for a set of nodes (stored in a time X node matrix) and then calculates the timepoint by timepoint multiplication of the temporal derivative of each pair of nodes at each point in time. The resultant scores are then temporally smoothed using a rolling mean -- the window length is defined by the user.


I initially wrote the code in Matlab and I've given it my best shot in Python, though it doesn't appear to be working properly. Would love some help on getting it right. Specifically, when I try and run the script, no variables are created. Not sure what I'm doing wrong -- anyone have any ideas?

Thanks

Mac


