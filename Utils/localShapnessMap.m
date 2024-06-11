function fmap = localShapnessMap(I)

%---< Parameters >---%
wsize = 11;
%---< Parameters >---%

Ig = rgb2grey(I);

[Mag,~] = imgradient(Ig);

h = fspecial('gaussian', wsize, wsize/6);
fmap = imfilter(Mag, h, 'replicate');

return
