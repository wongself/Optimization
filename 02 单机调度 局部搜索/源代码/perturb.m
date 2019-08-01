function permutation=perturb(permutation)
%% 该函数用于随机置换两个不同的任务
%permutation      	input     置换序列
%jobs               input     任务结构
%delay              output    当前调度延迟

numOfJobs=size(permutation,2);%利用size函数读取工件数量

%% 产生随机扰动
p1=floor(1+numOfJobs*rand());
p2=floor(1+numOfJobs*rand());

while p1==p2 %若两个标记相同，继续扰动
    p1=floor(1+numOfJobs*rand());
    p2=floor(1+numOfJobs*rand());    
end

%% 置换两个不同的任务
tmp=permutation(p1);
permutation(p1)=permutation(p2);
permutation(p2)=tmp;
end