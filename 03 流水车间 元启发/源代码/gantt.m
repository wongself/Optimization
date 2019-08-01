function gantt(flowGbest,TimeOfJobs)
%% 该函数用于绘制甘特图
%flowGbest      input     最优序列
%TimeOfJobs  	input     任务时间

numOfJobs=size(TimeOfJobs,1);%利用size函数读取任务数量
numOfMachines=size(TimeOfJobs,2);%利用size函数读取机器数量
color=['r','g','b','c','m','y'];

%% 完成时间
timeComplete=zeros(numOfJobs, numOfMachines);
timeComplete(flowGbest(1),1)=TimeOfJobs(flowGbest(1),1);
for k=2:numOfMachines
    timeComplete(flowGbest(1),k)=timeComplete(flowGbest(1),k-1)+TimeOfJobs(flowGbest(1),k);
end

for j=2:numOfJobs
    timeComplete(flowGbest(j),1)=timeComplete(flowGbest(j-1),1)+TimeOfJobs(flowGbest(j),1);
end

for j=2:numOfJobs
    for k=2:numOfMachines
        timeComplete(flowGbest(j),k)=max(timeComplete(flowGbest(j-1),k),timeComplete(flowGbest(j),k-1))+TimeOfJobs(flowGbest(j),k);
    end
end

%% 开始时间
timeStart=zeros(numOfJobs, numOfMachines);
for i=1:numOfJobs
    for j=1:numOfMachines
        timeStart(i,j)=timeComplete(i,j)-TimeOfJobs(i,j);
    end
end

%% 绘制甘特图
makespan=timeComplete(flowGbest(numOfJobs),numOfMachines);%获取makespan
figure,
title('流水车间调度的甘特图','FontSize',17),%图标题
hold on,
axis([0 makespan+500 0 numOfMachines+1]),%固定坐标范围
set(gca,'YTick',0:1:numOfMachines, 'XTick',0:1000:makespan),%设置坐标步长
for i=1:numOfJobs
    for j=1:numOfMachines
        rec(1) = timeStart(flowGbest(i),j);%矩形的横坐标
        rec(2) = numOfMachines+1-j-0.2;%矩形的纵坐标
        rec(3) = timeComplete(flowGbest(i),j)-timeStart(flowGbest(i),j);%矩形的宽度
        rec(4) = 0.4;%矩形的高度
        
        txt=sprintf('%d',int16(flowGbest(i)));%显示任务序号
        indexOfColor=mod(i,size(color,2))+1;%颜色索引
        rectangle('Position',rec,'LineWidth',0.2,'LineStyle','-','FaceColor',color(indexOfColor));%添加矩形
        text(timeStart(flowGbest(i),j)+0.4,numOfMachines+1-j,txt,'FontSize',14);%添加序号
    end
end
