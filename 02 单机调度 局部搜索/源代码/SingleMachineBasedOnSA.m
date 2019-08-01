%% 用模拟退火算法解决单机调度问题
% 姓名：王圣富
% 学号：1120161848
% 班号：07111605

%% 清空工作区
clc;clear

%% 载入数据

%更改instance的值来更换测试样例，如1、2、3、4…
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
    
numOfJobs=size(data,1);%利用size函数读取工件数量

jobs=struct([]);%创建工件结构体
for i=1:numOfJobs
    jobs(i).release=data(i,1);%工件的释放时间
    jobs(i).process=data(i,2);%工件的加工时间
    jobs(i).deliver=data(i,3);%工件的交工时间
end

%% 初始化
temperature=100*numOfJobs;%初始温度
ite=100;%内部蒙特卡洛循环迭代次数
temDropFactor=0.99;%冷却系数

permutation=randperm(numOfJobs);%利用随机置换函数创建一个随机调度序列

cnt=1;%统计迭代次数
delay(cnt)=calculate(permutation,jobs);%每次迭代后的路线长度  

%% 迭代
while temperature>0.001 %停止迭代温度
    for i=1:ite %多次迭代扰动，一种蒙特卡洛方法，温度降低之前多次实验
        curdelay=calculate(permutation,jobs);%计算原调度总延迟
        newPermutation=perturb(permutation);%产生随机扰动
        newdelay=calculate(newPermutation,jobs);%计算新调度总延迟
        
        delta_e=newdelay-curdelay;%新老调度的差值，相当于能量
        if delta_e<0
            %新调度好于旧调度，用新调度代替旧调度
            permutation=newPermutation;
        else
            %温度越低，越不太可能接受新解；新老调度差值越大，越不太可能接受新解
            %以概率选择是否接受新解
            if exp(-delta_e/temperature)>rand()
                permutation=newPermutation;%可能得到较差的解
            end
        end        
    end
    cnt=cnt+1;%迭代次数加一
    delay(cnt)=calculate(permutation,jobs);%计算新调度距离
    temperature=temperature*temDropFactor;%温度不断下降
  
end  

%% 显示最优解
fprintf('The optimal makespan is: %d\n',min(delay));
fprintf('The order is: \n');
for i=1:numOfJobs
    fprintf('%3d\n',permutation(i));
end
fprintf('\n');

%% 绘制迭代图
figure,
plot(delay),
title('单机调度的训练过程图','FontSize',17),%图标题
xlabel('迭代次数'),%横轴名称
ylabel('延迟时间'),%纵轴名称
grid on;

%% 绘制甘特图
gantt(permutation,jobs);
