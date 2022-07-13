#include <stdio.h>
#include <stdlib.h>
#define ARR_SIZE 50

/**
 * Computes the difference between two integers
 * @param num1 one of the numbers between which the function will compute difference
 * @param num2 the other number
 * @return diff difference between the two given numbers
 */
int diff_between(int num1, int num2) {
	int diff = num1 - num2;
	if (diff < 0)
		diff = -diff;
	return diff;
}

/**
 * Initiates the given array's given part with all zeros
 * @param array the array which the function will initiate with zeros
 * @param size the size of the side of the square which is array's part that the function will initiate
 * @return no return
 */
void init0(int array[ARR_SIZE][ARR_SIZE], int size) {
	for (int row = 0; row < size; row++)
		for (int col = 0; col < size; col++)
			array[row][col] = 0;
	return;
}

/**
 * Finds the safest slot for Joey's Ferrari
 * @param area the array, a part of which represents the car park
 * @param safest_slot the array that will contain x and y coordinates of the safest slot
 * @param size_of_area the side of the square part that represents the car park
 * @return no return
 */
void find_safest(int area[ARR_SIZE][ARR_SIZE], int safest_slot[2], int size_of_area) {
	int largest_distance = 0, distance, least_distance;
	
	for (int row = 0; row < size_of_area; row++) {
		for (int col = 0; col < size_of_area; col++) {
			if (area[row][col] == 0) {
				least_distance = 99;
				
				for (int r_car = 0; r_car < size_of_area; r_car++) {
					for (int c_car = 0; c_car < size_of_area; c_car++) {
						if (area[r_car][c_car] == 1) {
							distance = diff_between(r_car, row);
							distance += diff_between(c_car, col);
							if (distance < least_distance)
								least_distance = distance;
						}
					}
				}
				if (least_distance > largest_distance) {
					largest_distance = least_distance;
					safest_slot[0] = row;
					safest_slot[1] = col;
				}
				else if (least_distance == largest_distance) {
					//first check if col<, then if row>
					if (col < safest_slot[1]) {
						safest_slot[0] = row;
						safest_slot[1] = col;
					}
					else if (col == safest_slot[1] && row > safest_slot[0]) {
						safest_slot[0] = row;
					}
				}
			}
		}
	}
	return;
}

int main() {
	//get size and the number of cars and check errors
	int size_of_area;
	printf("Size: ");
	scanf("%d", &size_of_area);
	
	while (size_of_area > 50 || size_of_area < 1) {
		printf("Size must be between 50 and 1\n");
		printf("Size: ");
		scanf("%d", &size_of_area);
	}
	
	int parked_cars;
	printf("Cars: ");
	scanf("%d", &parked_cars);
	
	if (parked_cars < 0) {
		printf("Number of parked cars cannot be negative!\n");
		return EXIT_FAILURE;
	}
	else if (parked_cars == 0) {
		printf("Best Slot Found In: 1 1\n"); //If it is zero, no need for doing all the processes.
		return EXIT_SUCCESS;
	}
	else if (parked_cars > size_of_area * size_of_area) {
		printf("There is not enough space for %d cars. There are only %d spaces.\n",
		       parked_cars, size_of_area * size_of_area); //Assumed parked_cars != 1 while size_of_area != 1. Plural forms are used.
		return EXIT_FAILURE;
	}
	else if (parked_cars == size_of_area * size_of_area) {
		printf("Best Slot Found In: 0 0\n");
		return EXIT_SUCCESS; //EXIT_SUCCESS instead of EXIT_FAILURE because this is what the test file desires.
	}
	
	//get the locations and construct the array that represents the car park
	int area[ARR_SIZE][ARR_SIZE];
	init0(area, size_of_area);
	
	int x, y;
	for (int car = 0; car < parked_cars; car++) {
		printf("Locations: ");
		scanf("%d %d", &x, &y);
		if (1 <= x && x <= size_of_area && 1 <= y && y <= size_of_area)
			area[size_of_area - y][x - 1] = 1; //Coordinates are converted in order to be processed by the program using an array
	}
	
	//find the safest slot
	int safest_slot[2] = {0, 0}; 
	find_safest(area, safest_slot, size_of_area);
	
	//convert array coordinates to real world coordinates
	int temp = safest_slot[1];
	safest_slot[1] = size_of_area - safest_slot[0];
	safest_slot[0] = temp + 1;
	
	//print the result
	printf("Best Slot Found In: %d %d\n", safest_slot[0], safest_slot[1]);	
	
	return EXIT_SUCCESS;
}
