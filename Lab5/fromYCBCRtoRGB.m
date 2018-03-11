% YCBCR: image to convert
% YCbCrTOrgb: convert matrix

function result = fromYCBCRtoRGB (YCBCR, YCbCrTOrgb)

%component
Y = YCBCR(:,:,1);
Cb = YCBCR(:,:,2);
Cr = YCBCR(:,:,3);

%Cast operation
Y = double (Y);
Cb = double (Cb);
Cr = double (Cr);

%Convertion
R = YCbCrTOrgb(1,1) * Y + YCbCrTOrgb(1,2) * (Cb-128) + YCbCrTOrgb(1,3) * (Cr-128);
G = YCbCrTOrgb(2,1) * Y + YCbCrTOrgb(2,2) * (Cb-128) + YCbCrTOrgb(2,3) * (Cr-128);
B = YCbCrTOrgb(3,1) * Y + YCbCrTOrgb(3,2) * (Cb-128) + YCbCrTOrgb(3,3) * (Cr-128);

%Cast operation
R = uint8 (R);
G = uint8 (G);
B = uint8 (B);

RGB = YCBCR;
RGB(:,:,1) = R;
RGB(:,:,2) = G;
RGB(:,:,3) = B;

result = RGB;