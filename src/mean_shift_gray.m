inpImg = '/Users/sabihabarlaskar/Documents/MATLAB/Segmentation_Data/gray/Baboon.bmp';

mean_shift_gray_segment(inpImg)
function mean_shift_gray_segment(inpImg)
   original = double(imread(inpImg));
   figure;

   num_pixels = size(original,1);  
   scale_factor = 64/num_pixels;
   original = imresize(original, scale_factor);
   subplot(3,3,1);
   colormap('gray');
   
   imagesc(original);
   title("Original Image");

   new_image = zeros(64,64);

   for i = 1:64
    for j = 1:64
    iter = 25;
    mean_val = [i,j,original(i,j)];
     while(iter>0)
        numerator = 0;
        denominator = 0;
        
        for i1 = 1:64
           for j1 = 1:64
              weight = exp(-1 * ((mean_val(1) - i1)^2 + (mean_val(2) - j1)^2 + (mean_val(3) - original(i1,j1))^2)/25);
              numerator = numerator + weight * [i1,j1,original(i1,j1)];
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
    new_image(i,j) = mean_val(3);
    end
   
   end
   

   subplot(3,3,2);
   colormap('gray');
   imagesc(new_image);
   title("Mean shift Filtered Image");
   subplot(3,3,3)
   mesh(new_image);
   title("Visualization of mean shift image");
   s_image = zeros(64,64);
  for x1 = 1:64
      for y1 = 1:64
          s_image(x1,y1) = (floor(new_image(x1,y1)/30))*30;
      end
  end
  
  subplot(3,3,4);
  imagesc(s_image);
  title("Segmented Image");
  subplot(3,3,5);
  mesh(s_image);
  title("Visualization of Segmented Image");
end
 

