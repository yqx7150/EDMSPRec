function [Samp] = strucrand(n1,n2,n3,line);






% Perform sliding window in the kspace


 for frameno = 1:n3,
     
% 
      
      
      y=-n1/2:1:n1/2-0.5;  % Create an array of N points between -N/2 and N/2
      x=(linspace(-n2/2,n2/2,length(y)));
      i=1;
    % clear kloc_all klocn;
         
     % Loop to traverse the kspace ; 0 to pi in steps of pi/72 -- 72
     % radial lines
     % Succesive frames are rotated by pi/72 [SHOULD CONFIRM from srikanth]
   
     
     inc = 0 + (pi /line)*rand;
    
     
     for ang=0:pi/line:pi-1e-3;
         klocn=complex(y*cos(ang+ (inc)),x*sin(ang+ (inc)));
         kloc_all(:,i)=klocn;
         i=i+1;
     end
     
     
     % Round the collected data to the nearest cartesian location   
     kcart=round(kloc_all+(0.5+0.5*1i));
    % plot(kcart,'*');title('k locations after nearest neighbor interpolation: Center (0,0)');
%     
%     
    % Next, shift the cartesian locations accordingly such that the center
    % is now at (N/2,N/2); {Previously the center in kcart was (0,0)}
    kloc1 = round(kcart)+((n1/2+1)+(n2/2+1)*1i);
    kloc1real = real(kloc1); kloc1real = kloc1real - n1*(kloc1real>n1);
    kloc1imag = imag(kloc1); kloc1imag = kloc1imag - n2*(kloc1imag>n2);
    kloc1real = kloc1real + n1*(kloc1real<1);
    kloc1imag = kloc1imag + n2*(kloc1imag<1);
    kloc1 = kloc1real + 1i*kloc1imag;
    
 
  % Use this when the radial lines = 24 per frame
%    Fill the data into a sqaure matrix of size (N x N); 
    %Subsequently, the filling is done for all the frames
    for i=1:size(kloc1,1)
        for j=1:size(kloc1,2)
       % D(real(kloc1(i,j)),imag(kloc1(i,j)),frameno)=  Data(i,j)*1e6;
        Samp(real(kloc1(i,j)),imag(kloc1(i,j)),frameno) = 1;
        
        end
    end




 end
         % Image time series for all the coils
end
