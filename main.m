path1='images//2.jpg';
path2='images//colorful.jpg';
path3='images//washed.tif';
path4='images//nis.jpg';
path5='images//dollar 3.jpg';
path6='images//OIP.jpg';
path7='images//pound .jpg';



f=imread(path3);

height=size(f,1);
width=size(f,2);
c=size(f,3);%color


if c == 1
    img_pix = HistogramEqualization(f);
    img_pix = uint8(img_pix);
    
    
    subplot(1,2,1),imshow(f);title('Before Gray Histogram.Equalized');
    subplot(1,2,2),imshow(img_pix);title('After Gray Histogram.Equalized');
    
    h = HistogramDiagram(f);% calculates the histogram of the histogram-equalized image img_pix using the same HistogramDiagram function.
    z = HistogramDiagram(img_pix);   
    
    x=0:255;    
    figure;
    subplot(1,2,1),bar(x,h,'black');title('Before Gray Histogram.Equalized');
    subplot(1,2,2),bar(x,z,'black');title('After Gray Histogram.Equalized');

      
else    
    hsv = rgb2hsv(f);
    insty = hsv(:,:,3);% intensity channel
    
    for i=1:height
        for j=1:width
          insty(i,j)= insty(i,j)*255;%Multiply each intensity value (insty(i,j)) by 255 to scale it to the range [0, 255].
        end
    end
    
    img_pix = HistogramEqualization(insty);
    
    for i=1:height
      for j=1:width        
        img_pix(i,j) = img_pix(i,j)/255; %Divide each pixel value (img_pix(i,j)) by 255 to scale it back to the range [0, 1].     
      end
    end
    
    hsv_mod = hsv;
    hsv_mod(:,:,3) = img_pix;% intensity channel
    rgb = hsv2rgb(hsv_mod);
    
    figure,subplot(1,2,1),imshow(f);title('Before Rgb Histogram.Equalized');
    subplot(1,2,2),imshow(rgb);title('After Rgb Histogram.Equalized');
   
    f_rgb=zeros(256,1);%[0-255}    
    f_rgb(:,1)=HistogramDiagram(f(:,:,1)); %Red  
    f_rgb(:,2)=HistogramDiagram(f(:,:,2)); %Green  
    f_rgb(:,3)=HistogramDiagram(f(:,:,3)); %Blue
    
    img_pix_rgb=zeros(256,1);    
    img_pix_rgb(:,1)=HistogramDiagram(round(rgb(:,:,1)*255)); %Red  
    img_pix_rgb(:,2)=HistogramDiagram(round(rgb(:,:,2)*255)); %Green  
    img_pix_rgb(:,3)=HistogramDiagram(round(rgb(:,:,3)*255)); %Blue
   
 
    mymap=[1 0 0; 0.2 1 0; 0 0.2 1];
     figure,subplot(1,2,1),bar(f_rgb);colormap(mymap);legend('RED CHANNEL','GREEN CHANNEL','BLUE CHANNEL');title('Before Rgb Histogram.Equalized');
       subplot(1,2,2),bar(img_pix_rgb);colormap(mymap);legend('RED CHANNEL','GREEN CHANNEL','BLUE CHANNEL');title('After Rgb Histogram.Equalized');
    
end