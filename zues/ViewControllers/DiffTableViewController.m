//
//  DiffTableViewController.m
//  zues
//
//  Created by mac on 2017/3/10.
//  Copyright © 2017年 v. All rights reserved.
//

#import "DiffTableViewController.h"
#import <IGListKit.h>
#import "Person.h"

@interface DiffTableViewController ()
@property (nonatomic,strong) NSArray<Person *> *oldPeople;
@property (nonatomic,strong) NSArray<Person *> *newPeople;
@property (nonatomic,strong) NSArray<Person *> *people;
@property (nonatomic,assign) BOOL usingOldPeople;
@end

@implementation DiffTableViewController

- (NSArray<Person *> *)oldPeople {
    if (!_oldPeople) {
        _oldPeople = @[
                       [[Person alloc] initWithPk:@1 Name:@"Kevin"],
                       [[Person alloc] initWithPk:@2 Name:@"Mike"],
                       [[Person alloc] initWithPk:@3 Name:@"Ann"],
                       [[Person alloc] initWithPk:@4 Name:@"Jane"],
                       [[Person alloc] initWithPk:@5 Name:@"Philip"],
                       [[Person alloc] initWithPk:@6 Name:@"Mona"],
                       [[Person alloc] initWithPk:@7 Name:@"Tami"],
                       [[Person alloc] initWithPk:@8 Name:@"Jesse"],
                       [[Person alloc] initWithPk:@9 Name:@"Jaed"],
                       ];
    }
    return _oldPeople;
}

- (NSArray<Person *> *)newPeople {
    if (!_newPeople) {
        _newPeople = @[
                       [[Person alloc] initWithPk:@2 Name:@"Mike"],
                       [[Person alloc] initWithPk:@10 Name:@"Marne"],
                       [[Person alloc] initWithPk:@5 Name:@"Philip"],
                       [[Person alloc] initWithPk:@1 Name:@"Kevin"],
                       [[Person alloc] initWithPk:@3 Name:@"Ryan"],
                       [[Person alloc] initWithPk:@8 Name:@"Jesse"],
                       [[Person alloc] initWithPk:@7 Name:@"Tami"],
                       [[Person alloc] initWithPk:@4 Name:@"Jane"],
                       [[Person alloc] initWithPk:@9 Name:@"Chen"],
                       ];
    }
    return _newPeople;
}

- (NSArray<Person *> *)people {
    if (!_people) {
        _people = self.oldPeople;
    }
    return _people;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _usingOldPeople=YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(onDiff)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)onDiff{
    NSArray *from=self.people;
    NSArray *to=_usingOldPeople?self.newPeople:self.oldPeople;
    _usingOldPeople=!_usingOldPeople;
    self.people=to;
    IGListIndexPathResult *result = IGListDiffPaths(0, 0, from, to, IGListDiffEquality).resultForBatchUpdates;
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:result.deletes withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView insertRowsAtIndexPaths:result.inserts withRowAnimation:UITableViewRowAnimationFade];
    for (IGListMoveIndexPath *indexPath in result.moves) {
        [self.tableView moveRowAtIndexPath:indexPath.from toIndexPath:indexPath.to];
    }
    [self.tableView endUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.people.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text=self.people[indexPath.row].name;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
