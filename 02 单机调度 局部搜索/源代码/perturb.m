function permutation=perturb(permutation)
%% �ú�����������û�������ͬ������
%permutation      	input     �û�����
%jobs               input     ����ṹ
%delay              output    ��ǰ�����ӳ�

numOfJobs=size(permutation,2);%����size������ȡ��������

%% ��������Ŷ�
p1=floor(1+numOfJobs*rand());
p2=floor(1+numOfJobs*rand());

while p1==p2 %�����������ͬ�������Ŷ�
    p1=floor(1+numOfJobs*rand());
    p2=floor(1+numOfJobs*rand());    
end

%% �û�������ͬ������
tmp=permutation(p1);
permutation(p1)=permutation(p2);
permutation(p2)=tmp;
end