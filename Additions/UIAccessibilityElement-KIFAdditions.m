//
//  UIAccessibilityElement-KIFAdditions.m
//  KIF
//
//  Created by Eric Firestone on 5/23/11.
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.

#import "UIAccessibilityElement-KIFAdditions.h"
#import "LoadableCategory.h"


MAKE_CATEGORIES_LOADABLE(UIAccessibilityElement_KIFAdditions)


@implementation UIAccessibilityElement (KIFAdditions)

+ (UIView *)viewContainingAccessibilityElement:(UIAccessibilityElement *)element;
{
    if([element isKindOfClass:NSClassFromString(@"UIAccessibilityElementMockView")]){
        return (UIView *)[element performSelector:@selector(view)];
    }
    
    while (element && ![element isKindOfClass:[UIView class]]) {
        element = [element accessibilityContainer];
        
        if([element isKindOfClass:NSClassFromString(@"UITableViewCellAccessibilityElement")]){
            UITableViewCell *cell = [element performSelector:@selector(tableViewCell)];
            
            //If the cell has a superview (has been loaded into the table) then the cell is the view we are after
            if(cell.superview)
                element = (id)cell;
        }
    }
    
    return (UIView *)element;
}

+ (UIView *)tableViewContainingAccessibilityElement:(UIAccessibilityElement *)element;
{
    while (element && ![element isKindOfClass:[UITableView class]]) {
        element = [element accessibilityContainer];
    }
    
    return (UIView *)element;
}

@end
