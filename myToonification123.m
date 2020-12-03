function [img,R] = myToonification123()
img = imread('circuit.jpg');
img = imresize(img,0.33);
% figure,imshow(img_s);
% title('True Image');
% truesize([600,800]);
imlab = rgb2lab(img);
smooth_lab = imbilatfilt(imlab,120,7);
img_smooth = lab2rgb(smooth_lab);
% figure,imshow(img_smooth);
% title('Bilateral Filter:80,7');
% truesize([600,800]);
figure,imshowpair(img,img_smooth,'montage');
truesize([600,1200]);
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
% 

%% edge detection
[x y z]=size(img);
if z==1
    rslt=edge(img,'canny');
elseif z==3
    img1=rgb2ycbcr(img);
    dx1=edge(img1(:,:,1),'canny');
    dx1=(dx1*255);
    img2(:,:,1)=dx1;
    img2(:,:,2)=img1(:,:,2);
    img2(:,:,3)=img1(:,:,3);
    rslt=ycbcr2rgb(uint8(img2));
end
R=rslt;
imshow(R);
end