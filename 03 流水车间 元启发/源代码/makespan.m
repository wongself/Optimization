function curMakespan=makespan(indivisual,TimeOfJobs)
%% �ú������ڼ��������Ӧ��ֵ
%indivisual      	input     ����
%TimeOfJobs       	input     ����ʱ��
%curMakespan        output    ������Ӧ��ֵ 

numOfJobs=size(TimeOfJobs,1);
numOfMachines=size(TimeOfJobs,2);

timeComplete=zeros(numOfJobs, numOfMachines);
timeComplete(indivisual(1),1)=TimeOfJobs(indivisual(1),1);
for k=2:numOfMachines
    timeComplete(indivisual(1),k)=timeComplete(indivisual(1),k-1)+TimeOfJobs(indivisual(1),k);
end

for j=2:numOfJobs
    timeComplete(indivisual(j),1)=timeComplete(indivisual(j-1),1)+TimeOfJobs(indivisual(j),1);
end

for j=2:numOfJobs
    for k=2:numOfMachines
        timeComplete(indivisual(j),k)=max(timeComplete(indivisual(j-1),k),timeComplete(indivisual(j),k-1))+TimeOfJobs(indivisual(j),k);
    end
end
curMakespan = timeComplete(indivisual(numOfJobs),numOfMachines);
