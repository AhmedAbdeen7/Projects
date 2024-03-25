#include <iostream>
#include <string>
#include <fstream>
#include <cfloat>
using namespace std;

struct node
{
    string date;
    double relative_exchange_rate;
};

// calculate the maximum subsequence sum and provide the indices bounding this sum
void Maximum_subsequence_sum(node array[], int num, int& i_m, int& j_m); 
// create a max heap
void Max_heap(node array[], int num);
// create a min heap
void Min_heap(node array[], int num);
// Heapify function for max heap
void MaxHeapify(node arr[], int num, int i);
// Heapify function for min heap
void MinHeapify(node arr[], int num, int i);
// swap function to be used in heapifying the arrays
void swap(node& one, node& two);
// An accessory function to calculate the mean if needed
double mean(node array[], int size);

int main()
{    

 int size = 10000;

node* Min_array = new node[size];
node* Max_array = new node[size];

Min_array[0].date = "No date";
Min_array[0].relative_exchange_rate = -DBL_MAX; // intializing the first element of the min heap
Max_array[0].date = "No date";
Max_array[0].relative_exchange_rate = DBL_MAX; // intializing the first element of the max heap
int i = 1;

ifstream input("euro-dollar(1).txt");
if (!input.is_open()) {
    cout << "Error opening the file." << endl;
    return 1; 

}

double sum = 0, Mean;
 while (i < size && input >> Min_array[i].date >> Min_array[i].relative_exchange_rate) 
 {
    sum += Min_array[i].relative_exchange_rate;

    i++;
 }
 input.close();
 Max_array = Min_array;
 Mean = sum / (i-1);

// calculating the relative exchange rate from the average for each date
 for (int j = 1;j < i;j++)
 {
  Min_array[j].relative_exchange_rate =  Min_array[j].relative_exchange_rate - Mean;

 }
 int i_m, j_m;

 Maximum_subsequence_sum(Min_array, i, i_m, j_m); 


 cout << "The contiguous period over which the sum of rate changes is maximum is from " << Min_array[i_m].date <<  " to " << Min_array[j_m].date;
 cout << endl;



Max_heap(Max_array, i);

ofstream output1("Max Heap file.txt"); // saving the max heap into a file


for (int j = 1;j < i;j++)
{
    output1 << Max_array[j].date << " " << Max_array[j].relative_exchange_rate << endl;
} 
output1.close();

ofstream output2("Min Heap file.txt"); // saving the min heap into a file

Min_heap(Min_array, i);

for (int j = 1;j < i;j++)
{
    output2 << Min_array[j].date << " " << Min_array[j].relative_exchange_rate << endl;
} 
output2.close();

int N;
char ans;


//  finding the N highest and N lowest exchange rate days over the whole data set
do 
{
cout << "Do you want the lowest or highest data changes? ";
cin >> ans;
if (ans == 'L' || ans == 'l')
{

    cout << " Enter the number of data changes you want ";
    cin >> N;
    cout << "Here are the dates of the lowest exchange rates" << endl;

    for (int j = 1;j <= N;j++)
    {
        cout << Min_array[j].date <<  endl;
    }
    break;

}

else if (ans == 'H' || ans == 'h')
{

        cout << " Enter the number of data changes you want";
        cin >> N;
        cout << "Here are the dates of the highest exchange rates" << endl;

        for (int j = 1;j <= N;j++)
        {
            cout << Max_array[j].date <<  endl;
        }
        break;
  
}

 else
 {
        cout << "Enter a valid answer" << endl;
 }

}
while (true);

    return 0;
}



void Maximum_subsequence_sum(node array[], int num, int& i_m, int& j_m)
{
    int i = 1;
    
    double S_ij = 0, S_max= 0;
     i_m = 0, j_m = 0;

    for (int j = 1;j < num; j++)
    {
        S_ij += array[j].relative_exchange_rate; 
    
    if(S_ij > S_max)
    {
        S_max = S_ij;
        i_m = i;
        j_m = j;
    }
    else if(S_ij <0)
    {
        i = j+1;
        S_ij = 0;
    }
    }


}

void MaxHeapify(node A[], int n, int i)
{
   int left = 2*i,	right = 2*i+1;

   int max = i;

    // Compare with left child

	if ((left < n) && (A[left].relative_exchange_rate > A[i].relative_exchange_rate)) 

		max = left;   else max = i;

    // Compare with right child

	if ((right < n) && (A[right].relative_exchange_rate > A[max].relative_exchange_rate))  

		max = right;

    // If the max is not the current node, swap and continue heapifying
	if (max != i)
    {
		swap (A[i], A[max]);

		MaxHeapify (A, n, max);
    }
}

void MinHeapify(node arr[], int n, int i) {
    int smallest = i;
    int left = 2*i;
    int right = 2*i + 1;

    // Compare with left child

    if (left < n && arr[left].relative_exchange_rate < arr[smallest].relative_exchange_rate) {
        smallest = left;
    }

    // Compare with right child

    if (right < n && arr[right].relative_exchange_rate < arr[smallest].relative_exchange_rate) {
        smallest = right;
    }

    // If the smallest is not the current node, swap and continue heapifying

    if (smallest != i) {
        swap(arr[i], arr[smallest]);

        MinHeapify(arr, n, smallest);
    }
}

void Max_heap(node array[], int num)
{
    for (int i = num/2;i > 0;i-- )
    {
        MaxHeapify(array, num, i); // heapify for the internal nodes
    }
}
void Min_heap(node array[], int num)
{
    for (int i = num/2;i > 0;i-- )
    {
        MinHeapify(array, num, i); // heapify for the internal nodes
    }
}

void swap(node& one, node& two)
{
    node temp = one;
    one = two;
    two = temp;
}

double mean(node array[], int size)
{
    double sum = 0;
    for (int i = 0;i < size;i++)
    {
        sum += array[i].relative_exchange_rate;
    }
    double mean = sum /size;
    return mean;
}