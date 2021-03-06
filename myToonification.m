function [img_smooth_org,R] = myToonification()
img_org = imread('circuit.jpg');
img = imresize(img_org,1);
figure,imshow(img);
title('True Image');
% truesize([600,800]);

%% Bilateral Filter
smooth_lab = rgb2lab(img);
for i =1:10
    smooth_lab = imbilatfilt(smooth_lab,12,2);
end
img_smooth = lab2rgb(smooth_lab);
img_smooth_org = imresize(img_smooth,1);

%% Median filter
img_smooth_org(:,:,1) = medfilt2(img_smooth_org(:,:,1), [7 7]);
img_smooth_org(:,:,2) = medfilt2(img_smooth_org(:,:,2), [7 7]);
img_smooth_org(:,:,3) = medfilt2(img_smooth_org(:,:,3), [7 7]);

% figure,imshow(img_smooth);
% title('Bilateral Filter:80,7');
% truesize([600,800]);
% figure,imshowpair(img_org,img_smooth_org,'montage');title('Original and smoothed - No resized');
% % truesize([600,1200]);
% img_s = img;
%% mean segmentation
% smooth_lab= medfilt2(imlab);
% orgImg = img;
% [rows, cols, channel] = size(img);
% pos =  zeros(rows, cols, 2);
% for ii = 1:rows
%     for jj = 1:cols
%         pos(ii, jj, 1) = ii;
%         pos(ii, jj, 2) = jj;
%     end
% end
% for i = 1:20
%     img = double(img);
%     newImg = img;
%     for ii = 1:rows
%         for jj = 1:cols
%             windowI = img;
%             windowS = pos;      
%             weightI = gauss(windowI, img(ii, jj, :), 20);
%             weightS = gauss(windowS, pos(ii, jj, :), 10);
%             weight = weightI.*weightS;
%             weight = weight/sum(weight(:));
%             newImg(ii, jj, 1) = img(ii, jj, 1) + 0.2*(sum(weight.*windowI(:,:,1), 'all') - img(ii, jj, 1));
%             newImg(ii, jj, 2) = img(ii, jj, 2) + 0.2*(sum(weight.*windowI(:,:,2), 'all') - img(ii, jj, 2));
%             newImg(ii, jj, 3) = img(ii, jj, 3) + 0.2*(sum(weight.*windowI(:,:,3), 'all') - img(ii, jj, 3));
%         end
%     end
%     img = newImg;
%     newImg = uint8(newImg);
%     fig = imshow(newImg);
%     truesize([600 800]);
%     title(string(i));
%     sum(abs(newImg - uint8(orgImg)), 'all')
%     pause(5);
% end
% 
% function filter = gauss(A, B, std)
%     x = (sum((A-B).^2, 3));
%     filter = exp(-x/std^2);
% end

%% Median filter
img(:,:,1) = medfilt2(img(:,:,1), [7 7]);
img(:,:,2) = medfilt2(img(:,:,2), [7 7]);
img(:,:,3) = medfilt2(img(:,:,3), [7 7]);

%% 

%% edge detection
% img = img_org;
[x y z]=size(img);
if z==1
    rslt=edge(img,'canny');
elseif z==3
    img1=rgb2ycbcr(img);
    dx1=edge(img1(:,:,1),'canny',0.3);
    dx1=(dx1*255);
    img2(:,:,1)=dx1;
    img2(:,:,2)=img1(:,:,2);
    img2(:,:,3)=img1(:,:,3);
    rslt=ycbcr2rgb(uint8(img2));
end
R=rslt;
% R(R>240) = 255;
% R(R<240) = 0;

R = imcomplement(R);
R = imresize(R,1);
R = im2double(R);
figure,imshow(R);

%%
img_final = img_smooth_org.*R;
figure,imshow(img_final);
title('No resize ,bil(12,2)-10 times');
%% uniform quantizaiton
%tol = 24
n = 1/24
[X_no_dither,map] = rgb2ind(img_final,n);
figure,imshow(X_no_dither,map);
title('No resize ,bil(12,2)-10 times Quantized - uniform');


end
