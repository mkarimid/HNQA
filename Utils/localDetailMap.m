function fmap = localDetailMap(I)

%---< Parameters >---%
SigD = 0.12;
epsil = 0.25;%(0.5*1)^2;
H = ones(7); % small average filter is enough
r = 12; % radius of the filter
%---< Parameters >---%

H = H/sum(H(:));

%---- luminance component
Ig = rgb2grey(I);


%--- filtered luminance component
IgPad = padimage(Ig,[3,3]);
L = conv2(IgPad, H, 'valid');

%--- local mean intensity (Base layer)
lMu = fastGF(Ig, r, epsil, 2.5);

%--- Detail layer weights
Sig2 = 2*SigD.^2;
sMap = exp(-1*(L - .5).^2 /Sig2)+1e-6; 
Ist = (Ig-lMu);

fmap = sMap.*Ist;

return

