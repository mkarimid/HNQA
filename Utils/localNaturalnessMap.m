function fmap = localNaturalnessMap(I)
I=rgb2gray(I);
window = fspecial('gaussian',7,7/6);
window = window/sum(sum(window));

mu            = filter2(window, I, 'same');
mu_sq         = mu.*mu;
sigma         = sqrt(abs(filter2(window, I.*I, 'same') - mu_sq));
fmap     = (I-mu)./(sigma+eps);

end

