% RGB: image to convert
% rgbTOYCbCr: convert matrix

function result = fromRGBtoYCBCR (RGB, rgbTOYCbCr)

%component
R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);

%Cast operation
R = double (R);
G = double (G);
B = double (B);

%Convertion
Y = rgbTOYCbCr(1,1) * R + rgbTOYCbCr(1,2) * G + rgbTOYCbCr(1,3) * B + 0;
Cb = rgbTOYCbCr(2,1) * R + rgbTOYCbCr(2,2) * G + rgbTOYCbCr(2,3) * B + 128;
Cr = rgbTOYCbCr(3,1) * R + rgbTOYCbCr(3,2) * G + rgbTOYCbCr(3,3) * B + 128;

%Cast operation
Y = uint8 (Y);
Cb = uint8 (Cb);
Cr = uint8 (Cr);

YCBCR = RGB;
YCBCR(:,:,1) = Y;
YCBCR(:,:,2) = Cb;
YCBCR(:,:,3) = Cr;

result = YCBCR;