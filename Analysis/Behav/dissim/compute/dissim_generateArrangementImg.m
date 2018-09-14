function G = dissim_generateArrangementImg(stimuli,data,trialID)
%% DISSIM_GENERATEARRANGEMENTIMG(STIMULI,DATA,TRIALID)
%
% generates scatter image with stimulus thumbnails
% embedding algorithm from a tsne visualisation script by Andre Karpathy
%
% NOTE: change comment on four lines below depending on wether you'd like
% to visualize actual ratings or MDS plots
%
% Input:
% stimuli: cell with file names
% data:    matrix with coordinates etc
% trialID: trialid to index correct files and mat rows
%
% Output:
% scatterimage: rgb image of final arrangement

imageFolder = '/Data/ArenaTrees/'; % specifies where to find the trees

% for rating visualisation:
 % idces = find(data(:,1)==trialID);
 % y  = data(idces,6:7);

% for rdm mds visualisation:
idces = trialID;
y = data;


images = helper_loadImages(imageFolder,stimuli(idces));

% center the coordinates
y = bsxfun(@minus, y, min(y));
y = bsxfun(@rdivide, y, max(y));



%% MAIN
S = 1200; % size of full embedding image
G = ones(S, S, 3, 'uint8').*150;
s = 80; % size of every single image

Ntake = size(y,1);
for i=1:Ntake

    if mod(i, 100)==0
        fprintf('%d/%d...\n', i, Ntake);
    end

    % location
    a = ceil(y(i, 1) * (S-s)+1);
    b = ceil(y(i, 2) * (S-s)+1);
    a = a-mod(a-1,s)+1;
    b = b-mod(b-1,s)+1;
    if G(a,b,1) ~= 150
        continue % spot already filled
    end

    I = squeeze(images(i,:,:,:));
    if size(I,3)==1, I = cat(3,I,I,I); end
    I = imresize(I, [s, s]);

    G(a:a+s-1, b:b+s-1, :) = I;

end

end
