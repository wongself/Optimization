%% �����Ŵ��ӽ���PSO���û���ˮ��������㷨
% ��������ʥ��
% ѧ�ţ�1120161848
% ��ţ�07111605

%% ��չ�����
clc;clear

%% ��������

%����instance��ֵ������������������1��2��3��4��
instance = 4;

if instance == 1
    data=load('Instance_01.txt');
elseif instance == 2
    data=load('Instance_02.txt');
elseif instance == 3
    data=load('Instance_03.txt');
elseif instance == 4
    data=load('Instance_04.txt');
elseif instance == 5
    data=load('Instance_05.txt');
end
    
numOfJobs=size(data,1);%����size������ȡ��������
numOfMachines=size(data,2)/2;%����size������ȡ��������
TimeOfJobs=zeros(numOfJobs,numOfMachines);
for i = 1:numOfMachines
    TimeOfJobs(:,i) = data(:,2*i);
end

%% ��ʼ������
numOfIterations=2500;%��������
numOfIndivisual=150;%������Ŀ
individual=zeros(numOfIndivisual,numOfJobs);%��Ⱥ��Ϣ

for i=1:numOfIndivisual
    individual(i,:)=randperm(numOfJobs);%ʹ������û����������������
end

%% ������Ⱥ��Ӧ��
fitOfIndivisual=fitness(individual,TimeOfJobs);%������Ⱥ��Ӧ��
[~,index]=min(fitOfIndivisual);%��¼�����±�
flowPbest=individual;%��ǰ��������
flowGbest=individual(index,:);%��ǰȫ������
recordPbest=inf*ones(1,numOfIndivisual);%�������ż�¼
recordGbest=fitOfIndivisual(index);%Ⱥ�����ż�¼
newIndivisual=individual;%������Ⱥ��Ϣ�ı��ݣ��Ա����

%% ѭ��Ѱ������·��
flowLbest1=zeros(1,numOfIterations);
for ite=1:numOfIterations
    %������Ӧ��ֵ
    fitOfIndivisual=fitness(individual,TimeOfJobs);
    
    %���µ�ǰ���ź���ʷ����
    for i=1:numOfIndivisual
        if fitOfIndivisual(i)<recordPbest(i) %����ǰֵ������ʷ��������
            recordPbest(i)=fitOfIndivisual(i);%�����
            flowPbest(i,:)=individual(i,:);
        end
        if fitOfIndivisual(i)<recordGbest %����ǰֵ������ʷȫ������
            recordGbest=fitOfIndivisual(i);%�����
            flowGbest=individual(i,:);
        end
    end
    
    [~,index]=min(recordPbest);%��¼���������е������±�
    recordGbest(ite)=recordPbest(index);%��¼��Ⱥ�����Ÿ���
    
    
    for i=1:numOfIndivisual
       %% �������
        c1=round(rand*(numOfJobs-1))+1;   %��������λ
        c2=round(rand*(numOfJobs-1))+1;   %��������λ
        while c1==c2
            c1=round(rand*(numOfJobs-2))+1;
            c2=round(rand*(numOfJobs-2))+1;
        end
        temp=newIndivisual(i,c1);
        newIndivisual(i,c1)=newIndivisual(i,c2);
        newIndivisual(i,c2)=temp;
        
        %�µ�makespan��С�����
        curMakespan=makespan(newIndivisual(i,:),TimeOfJobs);
        if fitOfIndivisual(i)>curMakespan
            individual(i,:)=newIndivisual(i,:);
        end
    end

    [~,index]=min(fitOfIndivisual);%��¼���ŵ���Ӧֵ�����±�
    flowLbest1(ite)=fitOfIndivisual(index);%��¼��������ʱ����Ӧֵ
    flowGbest=individual(index,:);%��¼��ǰ���Ž�
end

%% ���Ƶ���ͼ
figure,
plot(flowLbest1),
hold on,
title('��ˮ������ȵ��㷨�Ƚ�','FontSize',17),%ͼ����
xlabel('��������'),%��������
ylabel('��Ӧ��ֵ'),%��������
grid on;%����������

%%
%%
%%
%%
%%
%% ��ʼ������
numOfIterations=2500;%��������
numOfIndivisual=150;%������Ŀ
individual=zeros(numOfIndivisual,numOfJobs);%��Ⱥ��Ϣ

for i=1:numOfIndivisual
    individual(i,:)=randperm(numOfJobs);%ʹ������û����������������
end

%% ������Ⱥ��Ӧ��
fitOfIndivisual=fitness(individual,TimeOfJobs);%������Ⱥ��Ӧ��
[value,index]=min(fitOfIndivisual);%��¼�����±�
flowPbest=individual;%��ǰ��������
flowGbest=individual(index,:);%��ǰȫ������
recordPbest=inf*ones(1,numOfIndivisual);%�������ż�¼
recordGbest=fitOfIndivisual(index);%Ⱥ�����ż�¼
newIndivisual=individual;%������Ⱥ��Ϣ�ı��ݣ��Ա����

%% ѭ��Ѱ������·��
flowLbest2=zeros(1,numOfIterations);
for ite=1:numOfIterations
    %������Ӧ��ֵ
    fitOfIndivisual=fitness(individual,TimeOfJobs);
    
    %���µ�ǰ���ź���ʷ����
    for i=1:numOfIndivisual
        if fitOfIndivisual(i)<recordPbest(i) %����ǰֵ������ʷ��������
            recordPbest(i)=fitOfIndivisual(i);%�����
            flowPbest(i,:)=individual(i,:);
        end
        if fitOfIndivisual(i)<recordGbest %����ǰֵ������ʷȫ������
            recordGbest=fitOfIndivisual(i);%�����
            flowGbest=individual(i,:);
        end
    end
    
    [~,index]=min(recordPbest);%��¼���������е������±�
    recordGbest(ite)=recordPbest(index);%��¼��Ⱥ�����Ÿ���
    
    
    for i=1:numOfIndivisual
       %% ��������Ž��н���
        c1=unidrnd(numOfJobs-1);%��������λ
        c2=unidrnd(numOfJobs-1);%��������λ
        while c1==c2
            c1=round(rand*(numOfJobs-2))+1;
            c2=round(rand*(numOfJobs-2))+1;
        end
        chb1=min(c1,c2);
        chb2=max(c1,c2);
        cros=flowPbest(i,chb1:chb2);
        ncros=size(cros,2);      
        %ɾ���뽻��������ͬԪ��
        for j=1:ncros
            for k=1:numOfJobs
                if newIndivisual(i,k)==cros(j)%�������������
                    newIndivisual(i,k)=0;%������
                    for t=1:numOfJobs-k %����newIndivisual(i,k+t-1)��newIndivisual(i,k+t)
                        temp=newIndivisual(i,k+t-1);
                        newIndivisual(i,k+t-1)=newIndivisual(i,k+t);
                        newIndivisual(i,k+t)=temp;
                    end
                end
            end
        end
        %���뽻������
        newIndivisual(i,numOfJobs-ncros+1:numOfJobs)=cros;
        %�µ�makespan��С�����
        curMakespan=makespan(newIndivisual(i,:),TimeOfJobs);
        if fitOfIndivisual(i)>curMakespan
            individual(i,:)=newIndivisual(i,:);
        end
        
       %% ��ȫ�����Ž��н���
        c1=round(rand*(numOfJobs-2))+1;  %��������λ
        c2=round(rand*(numOfJobs-2))+1;  %��������λ
        while c1==c2
            c1=round(rand*(numOfJobs-2))+1;
            c2=round(rand*(numOfJobs-2))+1;
        end
        chb1=min(c1,c2);
        chb2=max(c1,c2);
        cros=flowGbest(chb1:chb2); 
        ncros=size(cros,2);      
        %ɾ���뽻��������ͬԪ��
        for j=1:ncros
            for k=1:numOfJobs
                if newIndivisual(i,k)==cros(j)%�������������
                    newIndivisual(i,k)=0;%������
                    for t=1:numOfJobs-k %����newIndivisual(i,k+t-1)��newIndivisual(i,k+t)
                        temp=newIndivisual(i,k+t-1);
                        newIndivisual(i,k+t-1)=newIndivisual(i,k+t);
                        newIndivisual(i,k+t)=temp;
                    end
                end
            end
        end
        %���뽻������
        newIndivisual(i,numOfJobs-ncros+1:numOfJobs)=cros;
        %�µ�makespan��С�����
        curMakespan=makespan(newIndivisual(i,:),TimeOfJobs);
        if fitOfIndivisual(i)>curMakespan
            individual(i,:)=newIndivisual(i,:);
        end
        
       %% �������
        c1=round(rand*(numOfJobs-1))+1;   %��������λ
        c2=round(rand*(numOfJobs-1))+1;   %��������λ
        while c1==c2
            c1=round(rand*(numOfJobs-2))+1;
            c2=round(rand*(numOfJobs-2))+1;
        end
        temp=newIndivisual(i,c1);
        newIndivisual(i,c1)=newIndivisual(i,c2);
        newIndivisual(i,c2)=temp;
        
        %�µ�makespan��С�����
        curMakespan=makespan(newIndivisual(i,:),TimeOfJobs);
        if fitOfIndivisual(i)>curMakespan
            individual(i,:)=newIndivisual(i,:);
        end
    end

    [value,index]=min(fitOfIndivisual);%��¼���ŵ���Ӧֵ�����±�
    flowLbest2(ite)=fitOfIndivisual(index);%��¼��������ʱ����Ӧֵ
    flowGbest=individual(index,:);%��¼��ǰ���Ž�
end

%% ���Ƶ���ͼ
plot(flowLbest2);
