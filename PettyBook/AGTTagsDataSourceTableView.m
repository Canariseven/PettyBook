//
//  AGTTagsDataSourceTableView.m
//  PettyBook
//
//  Created by Carmelo Ruymán Quintana Santana on 29/3/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

#import "AGTTagsDataSourceTableView.h"
#import "AGTTagTableViewCell.h"
@implementation AGTTagsDataSourceTableView
-(id)initWhitArrayOfTags:(NSArray *)tags{
    if (self = [super init]) {
        _tags = tags;
    }
    return self;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tags.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AGTTagTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL_FOR_TAGS];
    if (cell == nil) {
        // La tenemos que crear nosotros desde cero
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AGTTagTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.tagLabel.text = self.tags[indexPath.row];

    return cell;
}
@end
