function mtd = coupling(data,window)
%COUPLING       Multiplication of Temporal Derivatives
%
%  mtd = coupling(data,window);
%
%  This code creates a time-resolved connectivity matrix for a given window
%  length. See http://www.ncbi.nlm.nih.gov/pubmed/26231247 for more details.
%
%  Input:      data     time-series organized in 'time x nodes' matrix
%              window   window length (in time-points)
%
%  Output:     mtd      time-resolved connectivity matrix


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

mtd_filter = 1/window*ones(window,1);

mtd = zeros(ts,nodes,nodes);

for j = 1:nodes
    for k = 1:nodes
        mtd(2:end,j,k) = filter(mtd_filter,1,fc(:,j,k));
    end
end

mtd(1:round(window/2),:,:) = [];
mtd(round(ts-window):ts,:,:) = 0;

mtd = permute(mtd,[2,3,1]);

mtd(:,:,1) = mtd(:,:,2);


end
