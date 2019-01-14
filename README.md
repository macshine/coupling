coupling
========

Matlab and Python scripts for calculating functional coupling between time series data.

I've created this repository to store some code that I've written to allow for the estimation of dynamic functional coupling between timeseries using the multiplication of temporal derivatives. Briefly, the function takes timeseries data for a set of nodes (stored in a time X node matrix) and then calculates the point-wise multiplication of the temporal derivative of each pair of nodes at each point in time. The resultant scores are then temporally filtered using a simple moving average -- the window length of which is defined by the user.

If you have any questions, let me know at mac.shine@sydney.edu.au.

Mac

## Docker

To make usage of [coupling.py](coupling.py) reproducible, we provide a [Dockerfile](Dockerfile)
to build the container and run the python script. The container is provided for you
at [poldracklab/coupling](https://cloud.docker.com/u/poldracklab/repository/docker/poldracklab/coupling),
so you should not need to re-build unless you want to make further changes.

### How do I use the container?

You will need to [install Docker](https://docs.docker.com/install/) for your
platform of choice. Then, you will want to run the container and bind
the folder (in this example, in the present working directory) to /data
in the container. Here is how to run the container and open
up an ipython terminal:

```bash
$ docker run -v $PWD:/data -it poldracklab/coupling 
...
> from coupling import *
```

You can also change the --entrypoint to be something
other than iPython. Here is an example with regular python:

```bash
$ docker run -v $PWD:/data -it --entrypoint python poldracklab/coupling 
```

In both of the above, the working directory is /code (containing coupling.py), and we've 
mounted your $PWD to /data so you can add data files to use there. You can
now use the functions in coupling, and save any outputs to /data to persist
on your local machine. If you want to change the entrypoint to something else:

```bash
$ docker run -v $PWD:/data -it --entrypoint bash poldracklab/coupling 
(base) root@0d2bb5c3f857:/code#
```

A shell (bash) might be a useful entrypoint if you want to start working
on the command line inside the container.

### How do I build the container?

If you want to build the container locally, you can do the following:

```bash
docker build -t poldracklab/coupling .
```

### How do I update the provided container?

If you find a flaw with the provided container, the build for `poldracklab/coupling`
happens in the continuous integration defined in the [.circleci](.circleci) folder
which is currently run on a fork of this repository, [researchapps/coupling](https://www.github.com/researchapps/coupling). Thus, to make changes, open a pull request there first,
and on merge the container will be updated. The maintainer of researchapps/coupling
will forward the changes to the repository here.


## Support

If you have an issue or question, you can contact @macshine directly, or [open
an issue](https://www.github.com/macshine/coupling/issues) here and one of the maintainers will help you.
