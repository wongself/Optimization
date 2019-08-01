#include <iostream>
#include <algorithm>
#include <cstdio>

using namespace std;

const int numOfPiece = 8;//工件个数
const int INF = 0x3f3f3f3f;

int sequence[numOfPiece] = {0};//记录贪心情况下的排列顺序

struct PIECE
{
    int n;
    int release;//释放时间
    int process;//处理时间
    int deliver;//提交时间
} piece[numOfPiece];


int cmp(const void *a, const void *b)//用于未超时序列的比较函数
{
    return piece[*(int *)a].deliver - piece[*(int *)b].deliver;
}

int greedyWithPriority(struct PIECE array[])
{
    int TimeOfDelay = 0, curTime = 0, cnt = 0, T = numOfPiece;
    int mark[numOfPiece] = {0};

    while(T--)
    {
        int indexOfMaxPriority;
        int notimeout[numOfPiece] = {0}, indexOfNoTimeout = 0;//未超时序列
        int timeout[numOfPiece] = {0}, indexOfTimeout = 0;//已超时序列

        for(int i = 0; i < numOfPiece; ++i)
        {
            if(mark[i] == 0)
            {
                if(array[i].deliver - curTime <= 0)//若当前时间已达到当前任务的提交时间，则加入已超时序列
                {
                    timeout[indexOfTimeout++] = i;
                }
                else//若当前时间未达到当前任务的提交时间，则加入未超时序列
                {
                    notimeout[indexOfNoTimeout++] = i;
                }

                qsort(notimeout, indexOfNoTimeout, sizeof(notimeout[0]), cmp);//对提交时间升序快速排序
                qsort(timeout, indexOfTimeout, sizeof(timeout[0]), cmp);//对处理时间升序快速排序
                //先选未超时序列中提交时间最小的，若未超时序列为空，则渲已超时序列处理时间最小的
                indexOfMaxPriority = (indexOfNoTimeout > 0) ? notimeout[0] : timeout[0];
            }
        }
        mark[indexOfMaxPriority] = 1;
        sequence[cnt++] = array[indexOfMaxPriority].n;

        curTime = (curTime >= array[indexOfMaxPriority].release) ? curTime + array[indexOfMaxPriority].process : array[indexOfMaxPriority].release + array[indexOfMaxPriority].process;
        TimeOfDelay += (curTime > array[indexOfMaxPriority].deliver) ? curTime - array[indexOfMaxPriority].deliver : 0;
    }
    return TimeOfDelay;
}

int main(int argc, char **argv)
{
    freopen("SchedulingSample.txt", "r", stdin);

    for(int i = 0; i < numOfPiece; i++)
    {
        cin >> piece[i].release >> piece[i].process >> piece[i].deliver;
        piece[i].n = i + 1;
    }

    cout << "Output: " << greedyWithPriority(piece) << endl << "Sequence: ";
    for(int i = 0; i < numOfPiece; i++)
    {
        cout << sequence[i] << " ";
    }
    cout << endl;

    return 0;
}
