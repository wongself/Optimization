function fitOfIndivisual=fitness(indivisual,TimeOfJobs)
%% �ú������ڼ��������Ӧ��ֵ
%indivisual      	input     ����
%TimeOfJobs       	input     ����ʱ��
%fitOfIndivisual	output    ������Ӧ��ֵ 

numOfIndivisual=size(indivisual,1);
numOfJobs=size(TimeOfJobs,1);
numOfMachines=size(TimeOfJobs,2);
fitOfIndivisual=zeros(numOfIndivisual,1);

for i=1:numOfIndivisual
    timeComplete=zeros(numOfJobs, numOfMachines);
    timeComplete(indivisual(i,1),1)=TimeOfJobs(indivisual(i,1),1);
    for k=2:numOfMachines
        timeComplete(indivisual(i,1),k)=timeComplete(indivisual(i,1),k-1)+TimeOfJobs(indivisual(i,1),k);
    end

    for j=2:numOfJobs
        timeComplete(indivisual(i,j),1)=timeComplete(indivisual(i,j-1),1)+TimeOfJobs(indivisual(i,j),1);
    end

    for j=2:numOfJobs
        for k=2:numOfMachines
            timeComplete(indivisual(i,j),k)=max(timeComplete(indivisual(i,j-1),k),timeComplete(indivisual(i,j),k-1))+TimeOfJobs(indivisual(i,j),k);
        end
    end
    fitOfIndivisual(i) = timeComplete(indivisual(i,numOfJobs),numOfMachines);
end