clc;
clear all;
close all;
%%
datalength=100;
data=round(rand(1,datalength));
crctype="crc24c";

disp("Testing "+crctype+" with data length L="+datalength);
if datalength<20
    disp("Data:");
    disp(data);
end
disp('==============================================================')

[protected, patiy_bits]=AttachParityBits(data,crctype);
disp("Parity bits according "+crctype+ " poly:");
disp(patiy_bits);
[extracted,is_correct]=ExtractDataCheckParity(protected,crctype);
disp("Checking data")
if extracted==data
    disp("Data passed successfully")
else
    disp("Data mismatch")
end
if is_correct
    disp("CRC is correct")
else
    disp("CRC mismatch")
end
error_index=round(datalength*rand(1));
disp('==============================================================')
disp("Testing with error at "+error_index+" bit")
protected(error_index)=~protected(error_index);
[extracted,is_correct]=ExtractDataCheckParity(protected,crctype);
if extracted==data
    disp("Data passed successfully")
else
    disp("Data mismatch")
end
if is_correct
    disp("CRC is correct")
else
    disp("CRC mismatch")
end