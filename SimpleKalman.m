function [s,Px,K] = SimpleKalman(z)

persistent A B H Q R 
persistent x u P
persistent firstRun


if isempty(firstRun)
  A = 1;%n*n矩阵将上一时刻的状态映射到这个状态
  B = 0;%n*l矩阵代表可选的控制输入的的增益
  H = 1;%m*n矩阵表示状态变量x对观测变量z的影响
  
  Q = 0;%过程激励噪声协方差
  R = 16;%测量噪声协方差

  x = 10; %x的最开始的估计
  u = 0;%控住输入
  P =  0.001; %xk的估计与真实值的误差方差
  
  firstRun = 1;  
end

%时间更新
%向前推算状态变量
xp = A*x + B*u;
%向前推算误差协方差
Pp = A*P*A' + Q;

%测量更新
%计算卡尔曼增益
K = Pp*H'*inv(H*Pp*H' + R);
%由观察变量z，更新估计
x = xp + K*(z - H*xp);
%更新误差协方差
P = Pp - K*H*Pp;


s = x;
Px   = P;
