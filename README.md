coupling
========

Matlab and Python scripts for calculating functional coupling between time series data.


I've created this repository to store some code that I've written to allow for the estimation of dynamic functional coupling between timeseries using the multiplication of temporal derivatives. Briefly, the function takes timeseries data for a set of nodes (stored in a time X node matrix) and then calculates the point-wise multiplication of the temporal derivative of each pair of nodes at each point in time. The resultant scores are then temporally filtered using a simple moving average -- the window length of which is defined by the user.

If you have any questions, let me know at macshine@stanford.edu.

Mac


