//
//  SortViewController.m
//  YMTools
//
//  Created by Y on 2019/3/27.
//  Copyright © 2019 YM. All rights reserved.
//

#import "SortViewController.h"
#define EXCHANGE(num1, num2)  { num1 = num1 ^ num2;\
num2 = num1 ^ num2;\
num1 = num1 ^ num2;}
@interface SortViewController ()

@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int arr[8] = {20,14,30,5,8,58,12,99};
    
//    buddleSort(arr, 8);
//    selectSort(arr, 8);
    insertSort(arr, 8);
}


/**
 冒泡排序：大的值往后移，每次遍历获取到一个最大值放到最后。类似于冒泡。
 */
void buddleSort(int num[],int count)
{
    for (int i = 0; i < count - 1; i++) {
        for (int j = 0; j < count - i - 1; j++) {
            if (num[j] > num[j + 1]) {
                EXCHANGE(num[j], num[j + 1]);
            }
        }
    }
    for (int i = 0; i< count; i++) {
        printf("%d \n",num[i]);
    }
    
}


/**
 选择排序:每次选出最小的，排到已排序数据的队尾。
 不稳定排序。
 */
void selectSort(int num[], int count)
{
    for (int i = 0; i < count; i++) {
        int min = i;
        for (int j = i + 1; j < count; j++) {
            if (num[j] < num[min]) {
                min = j;
            }
        }
        if (i != min) {
            EXCHANGE(num[i], num[min]);
        }
    }
    for (int i = 0; i< count; i++) {
        printf("%d \n",num[i]);
    }
}


/**
 直接插入排序:将一个数据插入到已经排序的有序数组中，从而得到一个新的，个数加一的有序数组，适用于少量数据的排序。
 稳定排序。
 */
void insertSort(int num[], int count)
{
    //int arr[8] = {20,14,30,5,8,58,12,99};
    int i,j;
    for (i = 1; i < count; i++) {
        if (num[i] < num[i - 1]) {
            int temp = num[i];//14
            for (j = i; j > 0; j--) {
                if (num[j - 1] > temp) {
                    num[j] = num[j - 1];
                }
                else break;
            }
            num[j] = temp;
        }
    }
    for (int i = 0; i< count; i++) {
        printf("%d \n",num[i]);
    }
}


@end
