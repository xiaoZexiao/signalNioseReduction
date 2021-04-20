dt = 0.1;
t  = 0:dt:10;

Nsamples = length(t);

Xsaved = zeros(Nsamples, 3);
Zsaved = zeros(Nsamples, 1);

for k=1:Nsamples
  z = GetVolt();  
  [s,Px,K] = SimpleKalman(z);
  
  Xsaved(k,:) = [ s Px K ];
  Zsaved(k) = z;
end