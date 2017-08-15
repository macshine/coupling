 


function mtd = coupling2(data,window,direction,trim)
%COUPLING2       Time-resolved connectivity
%
%   MTD = coupling2(data,window);
%   MTD = coupling2(data,window,direction);
%   MTD = coupling2(data,window,direction,trim);
%
%	Creates a functional coupling metric from an input matrix 'data'
%	data: should be organized in 'time x nodes' matrix
%	window: smoothing parameter for simple moving average of coupling metric (1 = forward; 0 = middle [default])
%   trim: whether to trim zeros from the end of the 3d matrix (1=yes; 0=no [default])
%
%   Inputs:
%       data,
%           time series data organized as TIME x NODES.
%       window,
%           window length (time points).
%       direction,
%           mirrored or forward facing window
%       trim,
%           determines whether to trim data or append with zeros.
%
%       Note: see Shine et al (2015) for a discussion of window length and smoothing options.
%
%   Outputs:
%       MTD,
%           time-varying connectivity matrix
%
%
%
%
%



    if isempty(direction)
        trim=0;
    end

    if isempty(trim)
        trim=0;
    end

    %define variables
    [ts,nodes] = size(data);

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



    %temporal smoothing (credit: T. C. O'Haver, 2008.)

    mtd_temp = zeros(nodes,nodes,ts-1);


    for j = 1:nodes
        for k = 1:nodes
            mtd_temp(j,k,:) = smooth(squeeze(fc(:,j,k)),window);
        end
    end


    %window type

    mtd = zeros(nodes,nodes,ts);

    if direction == 1

        mtd(:,:,1:ts-round(window/2+1)) = mtd_temp(:,:,round(window/2+1):end);

    elseif direction == 0

        mtd(:,:,1:ts-1) = mtd_temp;

    end



    %trim ends?

    if trim == 1 && direction == 0

        mtd(:,:,ts-round(window/2):end) = [];
        mtd(:,:,1:round(window/2)) = [];

    elseif trim == 1 && direction == 1

        mtd(:,:,(ts-window):end) = [];

    end

end


