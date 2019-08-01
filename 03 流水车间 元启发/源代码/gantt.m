function gantt(flowGbest,TimeOfJobs)
%% �ú������ڻ��Ƹ���ͼ
%flowGbest      input     ��������
%TimeOfJobs  	input     ����ʱ��

numOfJobs=size(TimeOfJobs,1);%����size������ȡ��������
numOfMachines=size(TimeOfJobs,2);%����size������ȡ��������
color=['r','g','b','c','m','y'];

%% ���ʱ��
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

%% ��ʼʱ��
timeStart=zeros(numOfJobs, numOfMachines);
for i=1:numOfJobs
    for j=1:numOfMachines
        timeStart(i,j)=timeComplete(i,j)-TimeOfJobs(i,j);
    end
end

%% ���Ƹ���ͼ
makespan=timeComplete(flowGbest(numOfJobs),numOfMachines);%��ȡmakespan
figure,
title('��ˮ������ȵĸ���ͼ','FontSize',17),%ͼ����
hold on,
axis([0 makespan+500 0 numOfMachines+1]),%�̶����귶Χ
set(gca,'YTick',0:1:numOfMachines, 'XTick',0:1000:makespan),%�������경��
for i=1:numOfJobs
    for j=1:numOfMachines
        rec(1) = timeStart(flowGbest(i),j);%���εĺ�����
        rec(2) = numOfMachines+1-j-0.2;%���ε�������
        rec(3) = timeComplete(flowGbest(i),j)-timeStart(flowGbest(i),j);%���εĿ��
        rec(4) = 0.4;%���εĸ߶�
        
        txt=sprintf('%d',int16(flowGbest(i)));%��ʾ�������
        indexOfColor=mod(i,size(color,2))+1;%��ɫ����
        rectangle('Position',rec,'LineWidth',0.2,'LineStyle','-','FaceColor',color(indexOfColor));%��Ӿ���
        text(timeStart(flowGbest(i),j)+0.4,numOfMachines+1-j,txt,'FontSize',14);%������
    end
end
