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

int greedyWithPriority(struct PIECE array[])
{
    int TimeOfDelay = 0, curTime = 0, cnt = 0, T = numOfPiece;
    int mark[numOfPiece] = {0};

    while(T--)
    {
        double maxPriority = INF, curPriority = 0;
        int indexOfMaxPriority;

        for(int i = 0; i < numOfPiece; ++i)
        {
            if(mark[i] == 0)
            {
                curPriority = array[i].deliver*array[i].process;//贪心选择提交时间与处理时间乘积最小的
                if(maxPriority > curPriority)
                {
                    maxPriority = curPriority;
                    indexOfMaxPriority = i;
                }
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
