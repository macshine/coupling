
%creates a functional coupling metric from an input matrix 'data'
%data: should be organized in 'time x nodes' matrix
%smooth: smoothing parameter for simple moving average of coupling metric


function [fc, sma] = coupling(data,window)

%define variables
[ts,nodes] = size(data);
der = ts - 1;


%calculate temporal derivative
td = diff(data);


%standardize data
data_std = std(td);

for i = 1:nodes
    td(:,i) = td(:,i) / data_std(1,i);
end


% [...] = zscore(X,FLAG,DIM) standardizes X by working along the dimension
%    DIM of X. Pass in FLAG==0 to use the default normalization by N-1, or 1
%    to use N.


%functional coupling score

fc = bsxfun(@times,permute(td,[1,3,2]),permute(td,[1,2,3]));



%simple moving average

sma_filter = 1/window*ones(window,1);

sma = zeros(ts,nodes,nodes);

for j = 1:nodes
    
    for k = 1:nodes
        
        sma(2:end,j,k) = filter(sma_filter,1,fc(:,j,k));
        
    end
    
end


sma = permute(sma,[2,3,1]);

sma(:,:,1) = sma(:,:,2);

end




