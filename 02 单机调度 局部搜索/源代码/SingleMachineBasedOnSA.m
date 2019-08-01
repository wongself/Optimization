%% ��ģ���˻��㷨���������������
% ��������ʥ��
% ѧ�ţ�1120161848
% ��ţ�07111605

%% ��չ�����
clc;clear

%% ��������

%����instance��ֵ������������������1��2��3��4��
instance = 5;

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

jobs=struct([]);%���������ṹ��
for i=1:numOfJobs
    jobs(i).release=data(i,1);%�������ͷ�ʱ��
    jobs(i).process=data(i,2);%�����ļӹ�ʱ��
    jobs(i).deliver=data(i,3);%�����Ľ���ʱ��
end

%% ��ʼ��
temperature=100*numOfJobs;%��ʼ�¶�
ite=100;%�ڲ����ؿ���ѭ����������
temDropFactor=0.99;%��ȴϵ��

permutation=randperm(numOfJobs);%��������û���������һ�������������

cnt=1;%ͳ�Ƶ�������
delay(cnt)=calculate(permutation,jobs);%ÿ�ε������·�߳���  

%% ����
while temperature>0.001 %ֹͣ�����¶�
    for i=1:ite %��ε����Ŷ���һ�����ؿ��巽�����¶Ƚ���֮ǰ���ʵ��
        curdelay=calculate(permutation,jobs);%����ԭ�������ӳ�
        newPermutation=perturb(permutation);%��������Ŷ�
        newdelay=calculate(newPermutation,jobs);%�����µ������ӳ�
        
        delta_e=newdelay-curdelay;%���ϵ��ȵĲ�ֵ���൱������
        if delta_e<0
            %�µ��Ⱥ��ھɵ��ȣ����µ��ȴ���ɵ���
            permutation=newPermutation;
        else
            %�¶�Խ�ͣ�Խ��̫���ܽ����½⣻���ϵ��Ȳ�ֵԽ��Խ��̫���ܽ����½�
            %�Ը���ѡ���Ƿ�����½�
            if exp(-delta_e/temperature)>rand()
                permutation=newPermutation;%���ܵõ��ϲ�Ľ�
            end
        end        
    end
    cnt=cnt+1;%����������һ
    delay(cnt)=calculate(permutation,jobs);%�����µ��Ⱦ���
    temperature=temperature*temDropFactor;%�¶Ȳ����½�
  
end  

%% ��ʾ���Ž�
fprintf('The optimal makespan is: %d\n',min(delay));
fprintf('The order is: \n');
for i=1:numOfJobs
    fprintf('%3d\n',permutation(i));
end
fprintf('\n');

%% ���Ƶ���ͼ
figure,
plot(delay),
title('�������ȵ�ѵ������ͼ','FontSize',17),%ͼ����
xlabel('��������'),%��������
ylabel('�ӳ�ʱ��'),%��������
grid on;

%% ���Ƹ���ͼ
gantt(permutation,jobs);
