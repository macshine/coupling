
%creates a functional coupling metric from an input matrix 'data'
%data: should be organized in 'time x nodes' matrix
%smooth: smoothing parameter for simple moving average of coupling metric

function [fc, sma] = coupling(data,smooth)

%define variables to be used later

[ts,nodes] = size(data);
der = ts - 1;


%calculate the temporal derivative of each timeseries

td = diff(data);


%standardize the data

data_std = std(data);
for i = 1:nodes
    td(:,i) = td(:,i) / data_std(1,i);
end


%calculate the functional coupling score

fc = zeros(der,nodes,nodes);
for t = 1:der
    for i = 1:nodes
        for j = 1:nodes
            fc(t,i,j) = td(t,i) .* td(t,j);
        end
    end
end


%temporal smoothing
%the 'tsmovavg' function only works on 2d data, so I've reshaped the matrix briefly to allow this

temp = reshape(fc,der,nodes^2);
sma = tsmovavg(temp, 's', smooth, 1);
sma = reshape(sma,der,nodes,nodes);

end


