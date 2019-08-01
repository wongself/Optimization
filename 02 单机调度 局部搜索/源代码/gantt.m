function gantt(permutation,jobs)
%% 该函数用于绘制甘特图
%flowGbest      input     最优序列
%TimeOfJobs  	input     任务时间

numOfJobs=size(permutation,2);%利用size函数读取工件数量
color=['r','g','b','c','m','y','m'];

curTime=zeros(numOfJobs);
%% 开始时间
curTime(1)=0;
for i=2:numOfJobs
    index=permutation(i);
    %% 计算当前时间
    if curTime(i-1)>=jobs(index).release %若当前时间大于工件释放时间，则当前时间加上工件加工时间
        curTime(i)=curTime(i-1)+jobs(index).process;
    else %否则当前时间置为工件释放时间加上工件加工时间
        curTime(i)=jobs(index).release+jobs(index).process;
    end 
end

%% 绘制甘特图
figure,
title('单机调度的甘特图','FontSize',17),%图标题
axis([0 curTime(numOfJobs)*1.3 0 1]),%固定坐标范围
for i=1:numOfJobs
    index=permutation(i);
    rec(1) = curTime(i);%矩形的横坐标
    rec(2) = 0.32;%矩形的纵坐标
    rec(3) = jobs(index).process;%矩形的宽度
    rec(4) = 0.36;%矩形的高度

    txt=sprintf('%d',permutation(i));%显示任务序号
    indexOfColor=mod(i,size(color,2))+1;%颜色索引
    rectangle('Position',rec,'LineWidth',0.2,'LineStyle','-','FaceColor',color(indexOfColor));%添加矩形
    text(curTime(i)+0.4,0.28,txt,'FontSize',14);%添加序号
    
end
