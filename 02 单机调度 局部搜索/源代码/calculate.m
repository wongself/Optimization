function delay=calculate(permutation,jobs)
%% �ú������ڼ���������ӳ�
%permutation      	input     �û�����
%jobs               input     ����ṹ
%delay              output    ��ǰ�����ӳ�

numOfJobs=size(permutation,2);%����size������ȡ��������

delay=0;
curTime=0;
for i=1:numOfJobs
    index=permutation(i);
    %% ���㵱ǰʱ��
    if curTime>=jobs(index).release %����ǰʱ����ڹ����ͷ�ʱ�䣬��ǰʱ����Ϲ����ӹ�ʱ��
        curTime=curTime+jobs(index).process;
    else %����ǰʱ����Ϊ�����ͷ�ʱ����Ϲ����ӹ�ʱ��
        curTime=jobs(index).release+jobs(index).process;
    end
    %% �����ӳ�ʱ��  
    if curTime>jobs(index).deliver %����ǰʱ����ڹ�������ʱ�䣬�ӳ�ʱ������
        delay=delay+curTime-jobs(index).deliver;
    else %��������
        delay=delay+0;
    end   
end
