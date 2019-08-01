#include <iostream>
#include <algorithm>
#include <cstdio>

using namespace std;

const int numOfPiece = 8;//工件个数
const int INF = 0x3f3f3f3f;

int minTimeOfDelay = INF;//记录最短延迟时间
int sequence[numOfPiece] = {0};//记录最短延迟时间情况下的排列顺序

struct PIECE
{
    int n;
    int release;//释放时间
    int process;//处理时间
    int deliver;//提交时间
} piece[numOfPiece];

void permutation(struct PIECE array[], int head, int tail)
{
    if(head == tail)
    {
        int TimeOfDelay = 0;
        int curTime = 0;
        int curSequence[numOfPiece] = {0};
        for(int i = 0; i <= tail; ++i)//对每一可能的顺序进行操作
        {
            curTime = (curTime >= array[i].release) ? curTime + array[i].process : array[i].release + array[i].process;//计算当前时间
            TimeOfDelay += (curTime > array[i].deliver) ? curTime - array[i].deliver : 0;//计算延迟时间
            curSequence[i] = array[i].n;//记录当前排序
        }
        if(minTimeOfDelay > TimeOfDelay)//若当前排序的延迟时间小于最优解
        {
            minTimeOfDelay = TimeOfDelay;//则更新最优解
            for(int i = 0; i < numOfPiece; i++)
            {
                sequence[i] = curSequence[i];//并记录最优解的排列顺序
            }
        }
        return;
    }
    else
    {
        for(int i = head; i <= tail; ++i)//全排列
        {
            swap(array[i], array[head]);
            permutation(array, head + 1, tail);
            swap(array[i], array[head]);
        }
    }
}

int main(int argc, char **argv)
{
    freopen("SchedulingSample.txt", "r", stdin);//文件流输入，以便于整理数据

    for(int i = 0; i < numOfPiece; i++)
    {
        cin >> piece[i].release >> piece[i].process >> piece[i].deliver;//通过cin输入
        piece[i].n = i + 1;//记录当前序号
    }

    permutation(piece, 0, numOfPiece - 1);//对工件排列顺序进行穷举搜索，寻找最优解

    cout << "Output: " << minTimeOfDelay << endl << "Sequence: ";
    for(int i = 0; i < numOfPiece; i++)
    {
        cout << sequence[i];
        if(i != numOfPiece - 1)
            cout << " ";
    }
    cout << endl;

    return 0;
}
