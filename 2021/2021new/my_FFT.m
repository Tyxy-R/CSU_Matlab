function [abs_H,angle_H,freq]=my_FFT(h,N,Fs)
% 自定义FFT函数，用于实现FFT
% 
% 输入参数：
% h - 需要FFT的向量
% N - FFT点数
% Fs  - 采样率
%
% 输出参数：
% abs_H  - 幅度响应
% angle_H  - 相位响应
% freq  - 画图的频率向量
%


H=fft(h);
H=H(1:N/2+1);
freq=Fs*(0:N/2)/(N);
angle_H=angle(H);
abs_H=abs(H);
end
