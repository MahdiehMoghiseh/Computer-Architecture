#include <iostream>

using namespace std;

void print_array(int *arr, int n) {
    // iterate over the array and print all
    // the elements in there
    for (int i = 0; i < n; i++)
        cout << arr[i] << endl;
}


void partition(int *arr, int n, // used to identify the input array
               int pi, // index of the pivot in the array
               int **part1, int *part1_length,  // for returning first part
               int **part2, int *part2_length // for returning second part
) {

    //  swap the pivot with the first element
    swap(arr[pi], arr[0]);

    // get the value of it
    int p = arr[0];

    // set the i to point to the element after first part.
    // first part is the part where all the elements of
    // it are smaller or equal to the pivot
    int i = 1;

    // iterate over the array and if the current element is
    // smaller or equal to the pivot append it to the first
    // part by swapping it with the element with index i
    // (which the element after the first part) and
    // incrementing i, by one
    for (int j = 1; j < n; j++)
        // if the current element is smaller or equal to the pivot
        if (arr[j] <= p)
            // append it the first part by swapping with the
            // element with index i which
            // the i++
            swap(arr[j], arr[i++]);

    // set i to point the last element
    i -= 1;

    // swap first element which is the pivot
    // with the last element of the first part
    swap(arr[i], arr[0]);

    // return the address and the length of the first part
    *part1 = arr;
    *part1_length = i;

    // return the address and the length of the second part
    *part2 = arr + i + 1;
    *part2_length = n - i - 1;
}

void quicksort(int *arr, int n) {
    // if the length is 1 or zero, it is already sorted
    if (n == 1 || n == 0)
        return;

    // select a random pivot
    int pi = rand() % n;

    // used to capture the outputs of the partition function which are the
    // information used to identify the part1 and part2 arrays
    int *part1, part1_length;
    int *part2, part2_length;

    // partition the array with the given pivot index and get the returned
    // values to find out where part1 and part2 are and what is the length
    // of them
    partition(arr, n, pi, &part1, &part1_length,
              &part2, &part2_length);

    // recursively call the quick sort on the first and the second part
    quicksort(part1, part1_length);
    quicksort(part2, part2_length);
}

int main() {
    srand(time(nullptr));

    // n is the length of the array
    int n;
    cin >> n; // get it from stdin

    int *arr = new int[n]; // allocate the array dynamically

    for (int i = 0; i < n; ++i)
        cin >> arr[i]; // get the elements one by one

    quicksort(arr, n); // sort the array :)

    print_array(arr, n); // print it finally

    return 0;
}