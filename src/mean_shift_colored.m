inpImg_color = '/Users/sabihabarlaskar/Documents/MATLAB/Segmentation_Data/BaboonRGB.bmp';

colored_mean_shift_segment(inpImg_color)
function colored_mean_shift_segment(inpImg_color)
   original = double(imread(inpImg_color));
   num_pixels = size(original,1);  
   scale_factor = 64/num_pixels;
   original = imresize(original, scale_factor);
   subplot(2,2,1);
   %colormap('gray');
   imagesc(uint8(original));

   new_image = zeros(64,64,3);
   s_image = zeros(64,64,3);
   for i = 1:64
    for j = 1:64
    iter = 25;
    mean_val = [i,j,original(i,j,1),original(i,j,2), original(i,j,3)];
     while(iter>0)
        numerator = 0;
        denominator = 0;
        
        for i1 = 1:64
           for j1 = 1:64
              weight = exp(-1 * ((mean_val(1) - i1)^2 + (mean_val(2) - j1)^2 + (mean_val(3) - original(i1,j1,1))^2 + (mean_val(4) - original(i1,j1,2))^2 + (mean_val(5) - original(i1,j1,3))^2)/100);
              numerator = numerator + weight * [i1,j1,original(i1,j1,1),original(i1,j1,2),original(i1,j1,3)];
              denominator = denominator + weight;
              
           end
           
        end
        mean_new = numerator / denominator;
        mean_shift = mean_new - mean_val;
        norm(mean_shift);
        if(norm(mean_shift)<0.1)
           iter = 0; 
        end
        mean_val = mean_new;
        
        
        iter = iter - 1;
     end
    new_image(i,j,1:3) = mean_val(3:5);

    s_image(i,j,1:3) = (floor(new_image(i,j,1:3)/30))* 30;
    end
   
   end
   
   
   subplot(2,2,2);
   imagesc(uint8(new_image));

   subplot(2,2,3);
   imagesc(uint8(s_image));
   
end
 

