clear all
close all
clc
a=arduino('COM5','Mega2560','Libraries','Servo');
%b=arduino('COM1','UNO','Libraries','Servo');
s=servo(a,'D9');
i=2;
x(1)=1;
t1=0;
c(1)=0;
ave=0;
hold on
h = animatedline;
addpoints(h,0,0);
    axis([i-50 i+50 20 50]);
    drawnow;
g=animatedline('Color','r');
writePosition(s,0);
pause(3);
for i=1:20
    x(i)=i
    c(i)= readVoltage(a,'A2')*10;
    if c(i)<25
        c(i)=25-(c(i)-25);
    end
end
i=21
ave=c(i-1-10)+c(i-1-9)+c(i-1-8)+c(i-1-7)+c(i-1-6)+c(i-1-5)+c(i-1-4)+c(i-1-3)+c(i-1-2)+c(i-1-1)+c(i-1);
ave2=ave/11;
while(1)
    tic
    x(i)=i;
    c(i)= readVoltage(a,'A2')*10;
    if c(i)<25
        c(i)=25-(c(i)-25);
    end
    t=toc;
%     dif=sqrt((c(i)-c(i-1)).^2);
    ave=c(i-10)+c(i-9)+c(i-8)+c(i-7)+c(i-6)+c(i-5)+c(i-4)+c(i-3)+c(i-2)+c(i-1)+c(i);
    
    
    ave1=ave/11;
    difave=ave1-ave2;
    sig=c(i-20:i);
    [q,l] = wavedec(sig,3,'db1');
    [cd1,cd2,cd3] = detcoef(q,l,[1 2 3]);
    [y1] = myNeuralNetworkFunction1([cd1,cd2,cd3,ave1]);
    [maxValue, pos] = max(y1(:));
    ave2=ave1;
    switch pos
        case 1
            disp('closing')
        case 2
            disp('opening')
        case 3
            disp('forward wrist movement')
    end
    addpoints(h,x(i),c(i));
    axis([i-200 i 20 50]);
    drawnow;
    addpoints(g,x(i),ave1);
    axis([i-200 i 20 50]);
    drawnow;
    i=i+1;
end
