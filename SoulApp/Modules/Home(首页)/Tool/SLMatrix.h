//
//  SLMatrix.h
//  SoulApp
//
//  Created by shiyu on 2020/4/18.
//  Copyright © 2020 shiyu. All rights reserved.
//

#ifndef SLMatrix_h
#define SLMatrix_h

#import "SLPoint.h"

struct SLMatrix {
    NSInteger column;  //行
    NSInteger row;     //列
    CGFloat matrix[4][4]; //二维数组,存储行列信息,(row,column)几行几列
};

typedef struct SLMatrix SLMatrix;

//定义了一个函数(方法),该结构体有两个参数:行row和列column
static SLMatrix SLMatrixMake(NSInteger column, NSInteger row) {
    SLMatrix matrix;
    matrix.column = column;
    matrix.row = row;
    for(NSInteger i = 0; i < column; i++){
        for(NSInteger j = 0; j < row; j++){
            matrix.matrix[i][j] = 0;
        }
    }
    
    return matrix;
}

//该结构体有三个个参数:行row和列column和数据data(PS:这是个指针)
static SLMatrix SLMatrixMakeFromArray(NSInteger column, NSInteger row, CGFloat *data) {
    SLMatrix matrix = SLMatrixMake(column, row);
    for (int i = 0; i < column; i ++) {
        CGFloat *t = data + (i * row);
        for (int j = 0; j < row; j++) {
            matrix.matrix[i][j] = *(t + j);
        }
    }
    return matrix;
}

//定义了一个函数(方法),类型是XLMatrix 类型名是XLMatrixMutiply,该结构体有两个参数:XLMatrix a和XLMatrix b
static SLMatrix SLMatrixMutiply(SLMatrix a, SLMatrix b) {
    SLMatrix result = SLMatrixMake(a.column, b.row);
    for(NSInteger i = 0; i < a.column; i ++){
        for(NSInteger j = 0; j < b.row; j ++){
            for(NSInteger k = 0; k < a.row; k++){
                result.matrix[i][j] += a.matrix[i][k] * b.matrix[k][j];
            }
        }
    }
    return result;
}

//自定义的方法包含三个参数(位置,方向,角度)
static SLPoint SLPointMakeRotation(SLPoint point, SLPoint direction, CGFloat angle) {
    //    CGFloat temp1[4] = {direction.x, direction.y, direction.z, 1};
    //    DBMatrix directionM = DBMatrixMakeFromArray(1, 4, temp1);
    if (angle == 0) {
        return point;
    }
    
    CGFloat temp2[1][4] = {point.x, point.y, point.z, 1};
    //    DBMatrix pointM = DBMatrixMakeFromArray(1, 4, *temp2);
    
    SLMatrix result = SLMatrixMakeFromArray(1, 4, *temp2);
    
    //如果水平面存在的话,执行判断
    if (direction.z * direction.z + direction.y * direction.y != 0) {
        CGFloat cos1 = direction.z / sqrt(direction.z * direction.z + direction.y * direction.y);
        CGFloat sin1 = direction.y / sqrt(direction.z * direction.z + direction.y * direction.y);
        CGFloat t1[4][4] = {{1, 0, 0, 0}, {0, cos1, sin1, 0}, {0, -sin1, cos1, 0}, {0, 0, 0, 1}};
        SLMatrix m1 = SLMatrixMakeFromArray(4, 4, *t1);
        result = SLMatrixMutiply(result, m1);
    }
    
    //如果有值,执行判断
    if (direction.x * direction.x + direction.y * direction.y + direction.z * direction.z != 0) {
        CGFloat cos2 = sqrt(direction.y * direction.y + direction.z * direction.z) / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z);
        CGFloat sin2 = -direction.x / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z);
        CGFloat t2[4][4] = {{cos2, 0, -sin2, 0}, {0, 1, 0, 0}, {sin2, 0, cos2, 0}, {0, 0, 0, 1}};
        SLMatrix m2 = SLMatrixMakeFromArray(4, 4, *t2);
        result = SLMatrixMutiply(result, m2);
    }
    
    CGFloat cos3 = cos(angle);
    CGFloat sin3 = sin(angle);
    CGFloat t3[4][4] = {{cos3, sin3, 0, 0}, {-sin3, cos3, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 1}};
    SLMatrix m3 = SLMatrixMakeFromArray(4, 4, *t3);
    result = SLMatrixMutiply(result, m3);
    
    if (direction.x * direction.x + direction.y * direction.y + direction.z * direction.z != 0) {
        CGFloat cos2 = sqrt(direction.y * direction.y + direction.z * direction.z) / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z);
        CGFloat sin2 = -direction.x / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z);
        CGFloat t2_[4][4] = {{cos2, 0, sin2, 0}, {0, 1, 0, 0}, {-sin2, 0, cos2, 0}, {0, 0, 0, 1}};
        SLMatrix m2_ = SLMatrixMakeFromArray(4, 4, *t2_);
        result = SLMatrixMutiply(result, m2_);
    }
     //如果竖直平面有值的话,执行判断
    if (direction.z * direction.z + direction.y * direction.y != 0) {
        CGFloat cos1 = direction.z / sqrt(direction.z * direction.z + direction.y * direction.y);
        CGFloat sin1 = direction.y / sqrt(direction.z * direction.z + direction.y * direction.y);
        CGFloat t1_[4][4] = {{1, 0, 0, 0}, {0, cos1, -sin1, 0}, {0, sin1, cos1, 0}, {0, 0, 0, 1}};
        SLMatrix m1_ = SLMatrixMakeFromArray(4, 4, *t1_);
        result = SLMatrixMutiply(result, m1_);
    }
    
    SLPoint resultPoint = SLPointMake(result.matrix[0][0], result.matrix[0][1], result.matrix[0][2]);
    
    return resultPoint;
}



#endif /* SLMatrix_h */
