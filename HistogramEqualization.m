
function img_pix = HistogramEqualization(f)

height=size(f,1);
width=size(f,2);
color_occ = zeros(1,256);%store the occurrence count of each intensity value in the input image.
cumlf_pix = zeros(1,256);%which will store the cumulative frequency of each intensity value.
img_pix = zeros(height,width);

max_bin=0;%track the maximum intensity value

for i=1:height
    for j=1:width       
       value=f(i,j);% return the current pixel
       % Find max bin
       if value>max_bin
           max_bin=value;
       end
       color_occ(value+1)=color_occ(value+1)+1;
    end
end
for i = 1:256
    p = round((color_occ(i)/(height*width))*254);
    if i==1
        cumlf_pix(i)= p;
    else
        cumlf_pix(i)= p + cumlf_pix(i-1);
    end
end

for i=1:height
    for j=1:width
        img_pix(i,j)=cumlf_pix(f(i,j)+1);
    end
end

end


