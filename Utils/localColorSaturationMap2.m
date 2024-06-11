function fmap = localColorSaturationMap2(I)

%---< Parameters >---%
wsize = 11;
%---< Parameters >---%

hsv = rgb2hsv(I);
s = hsv(:,:,2);
v = hsv(:,:,3);
c1=0.8;
c2=0.3;
sig1=0.5;
sig2=0.3;
f1=exp(-0.5*(s-c1).^2/(sig1^2));
f2=exp(-0.5*(v-c2).^2/(sig2^2));

fmap = f1.*f2;


