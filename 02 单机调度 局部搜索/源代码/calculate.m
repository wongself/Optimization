function delay=calculate(permutation,jobs)
%% 该函数用于计算调度总延迟
%permutation      	input     置换序列
%jobs               input     任务结构
%delay              output    当前调度延迟

numOfJobs=size(permutation,2);%利用size函数读取工件数量

delay=0;
curTime=0;
for i=1:numOfJobs
    index=permutation(i);
    %% 计算当前时间
    if curTime>=jobs(index).release %若当前时间大于工件释放时间，则当前时间加上工件加工时间
        curTime=curTime+jobs(index).process;
    else %否则当前时间置为工件释放时间加上工件加工时间
        curTime=jobs(index).release+jobs(index).process;
    end
    %% 计算延迟时间  
    if curTime>jobs(index).deliver %若当前时间大于工件交工时间，延迟时间增加
        delay=delay+curTime-jobs(index).deliver;
    else %否则不增加
        delay=delay+0;
    end   
end
