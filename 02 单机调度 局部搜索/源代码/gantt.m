function gantt(permutation,jobs)
%% �ú������ڻ��Ƹ���ͼ
%flowGbest      input     ��������
%TimeOfJobs  	input     ����ʱ��

numOfJobs=size(permutation,2);%����size������ȡ��������
color=['r','g','b','c','m','y','m'];

curTime=zeros(numOfJobs);
%% ��ʼʱ��
curTime(1)=0;
for i=2:numOfJobs
    index=permutation(i);
    %% ���㵱ǰʱ��
    if curTime(i-1)>=jobs(index).release %����ǰʱ����ڹ����ͷ�ʱ�䣬��ǰʱ����Ϲ����ӹ�ʱ��
        curTime(i)=curTime(i-1)+jobs(index).process;
    else %����ǰʱ����Ϊ�����ͷ�ʱ����Ϲ����ӹ�ʱ��
        curTime(i)=jobs(index).release+jobs(index).process;
    end 
end

%% ���Ƹ���ͼ
figure,
title('�������ȵĸ���ͼ','FontSize',17),%ͼ����
axis([0 curTime(numOfJobs)*1.3 0 1]),%�̶����귶Χ
for i=1:numOfJobs
    index=permutation(i);
    rec(1) = curTime(i);%���εĺ�����
    rec(2) = 0.32;%���ε�������
    rec(3) = jobs(index).process;%���εĿ��
    rec(4) = 0.36;%���εĸ߶�

    txt=sprintf('%d',permutation(i));%��ʾ�������
    indexOfColor=mod(i,size(color,2))+1;%��ɫ����
    rectangle('Position',rec,'LineWidth',0.2,'LineStyle','-','FaceColor',color(indexOfColor));%��Ӿ���
    text(curTime(i)+0.4,0.28,txt,'FontSize',14);%������
    
end
