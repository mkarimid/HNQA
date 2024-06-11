function fmap = localContrastMap(I)

%---parameter---%
Wsize = 7;
%---parameter---%

Ig = rgb2grey(I);

R = (Wsize-1)/2;
se = strel('disk',R);
% localMax = ordfilt2(Ig,Wsize*Wsize,ones(Wsize,Wsize));
% localMax = imdilate(Ig, true(Wsize)); %==> faster than disk shape SE
localMax = imdilate(Ig, se);

% localMin = ordfilt2(Ig,1,ones(Wsize,Wsize));
% localMin = imerode(Ig, true(Wsize)); %==> faster than disk shape SE
localMin = imerode(Ig, se);

% each of the following equation can be used and tested 
% to find each one is better for our purpose.
%---EQ1:
% fmap = localMax - localMin;
%---EQ2:
fmap = (localMax - localMin)./(localMax + localMin + 0.00001);
%---EQ3:
% fmap = (localMax - localMin)./(localMax + localMin + 0.00001);
% fmap = log(fmap+0.00001);

return
