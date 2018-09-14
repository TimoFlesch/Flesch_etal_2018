
% ++
tmp = genParametrizedModelRDM(1,1,0);
tmp.choiceMat = zscore(tmp.choiceMat(:));
tmp.choiceMat = reshape(tmp.choiceMat,5,5);
figure(1);
subplot(2,2,1);
imagesc(tmp.choiceMat);
title('(+,+), (1,1)');
colormap('jet');
figure(2);
subplot(2,2,1);
image(scale01(rankTransform_equalsStayEqual(squareform(pdist(tmp.choiceMat(:))),1)),'CDataMapping','scaled','AlphaData',1);
title('(+,+), (1,1)');
colormap('jet');

% --
cm2 = tmp.choiceMat*(-1);
figure(1);
subplot(2,2,2);
imagesc(cm2);
title('(-,-), (-1)*(1,1)');
figure(2);
subplot(2,2,2);
image(scale01(rankTransform_equalsStayEqual(squareform(pdist(cm2(:))),1)),'CDataMapping','scaled','AlphaData',1);
title('(-,-), (-1)*(1,1)');

% +-
cm3 = flipud(tmp.choiceMat);
figure(1);
subplot(2,2,3);
imagesc(cm3);
title('(+,-), flipud(1,1)');
figure(2);
subplot(2,2,3);
image(scale01(rankTransform_equalsStayEqual(squareform(pdist(cm3(:))),1)),'CDataMapping','scaled','AlphaData',1);
title('(+,-), flipud(1,1)');

% -+
cm4 = fliplr(tmp.choiceMat);
figure(1);
subplot(2,2,4);
imagesc(cm4);
title('(-,+), fliplr(1,1)');
figure(2);
subplot(2,2,4);
image(scale01(rankTransform_equalsStayEqual(squareform(pdist(cm4(:))),1)),'CDataMapping','scaled','AlphaData',1);
title('(-,+), fliplr(1,1)');
