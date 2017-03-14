//
//  StoryboardViewController.m
//  zues
//
//  Created by mac on 2017/3/11.
//  Copyright © 2017年 v. All rights reserved.
//

#import "StoryboardViewController.h"
#import <IGListKit.h>
#import "Person.h"
#import "StoryboardLabelSectionController.h"

@interface StoryboardViewController ()<IGListAdapterDataSource,StoryboardLabelSectionControllerDelegate>
@property (nonatomic,strong) IGListAdapter *adapter;

@property (weak, nonatomic) IBOutlet IGListCollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray<Person *> *people;
@end

@implementation StoryboardViewController

-(IGListAdapter *)adapter{
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self workingRangeSize:0];
    }
    return _adapter;
}

- (NSMutableArray<Person *> *)people {
    if (!_people) {
        _people = @[
                       [[Person alloc] initWithPk:@1 Name:@"Littlefinger"],
                       [[Person alloc] initWithPk:@2 Name:@"Tommen Baratheon"],
                       [[Person alloc] initWithPk:@3 Name:@"Roose Bolton"],
                       [[Person alloc] initWithPk:@4 Name:@"Brienne of Tarth"],
                       [[Person alloc] initWithPk:@5 Name:@"Bronn"],
                       [[Person alloc] initWithPk:@6 Name:@"Gilly"],
                       [[Person alloc] initWithPk:@7 Name:@"Theon Greyjoy"],
                       [[Person alloc] initWithPk:@8 Name:@"Jaqen H'ghar"],
                       [[Person alloc] initWithPk:@9 Name:@"Cersei Lannister"],
                       [[Person alloc] initWithPk:@10 Name:@"Jaime Lannister"],
                       [[Person alloc] initWithPk:@11 Name:@"Tyrion Lannister"],
                       [[Person alloc] initWithPk:@12 Name:@"Melisandre"],
                       [[Person alloc] initWithPk:@13 Name:@"Missandei"],
                       [[Person alloc] initWithPk:@14 Name:@"Jorah Mormont"],
                       [[Person alloc] initWithPk:@15 Name:@"Khal Moro"],
                       [[Person alloc] initWithPk:@16 Name:@"Daario Naharis"],
                       [[Person alloc] initWithPk:@17 Name:@"Jon Snow"],
                       [[Person alloc] initWithPk:@18 Name:@"Arya Stark"],
                       [[Person alloc] initWithPk:@19 Name:@"Bran Stark"],
                       [[Person alloc] initWithPk:@20 Name:@"Sansa Stark"],
                       [[Person alloc] initWithPk:@21 Name:@"Daenerys Targaryen"],
                       [[Person alloc] initWithPk:@22 Name:@"Samwell Tarly"],
                       [[Person alloc] initWithPk:@23 Name:@"Tormund"],
                       [[Person alloc] initWithPk:@24 Name:@"Margaery Tyrell"],
                       [[Person alloc] initWithPk:@25 Name:@"Varys"],
                       [[Person alloc] initWithPk:@26 Name:@"Renly Baratheon"],
                       [[Person alloc] initWithPk:@27 Name:@"Joffrey Baratheon"],
                       [[Person alloc] initWithPk:@28 Name:@"Stannis Baratheon"],
                       [[Person alloc] initWithPk:@29 Name:@"Hodor"],
                       [[Person alloc] initWithPk:@30 Name:@"Tywin Lannister"],
                       [[Person alloc] initWithPk:@31 Name:@"The Hound"],
                       [[Person alloc] initWithPk:@32 Name:@"Ramsay Bolton"],
                       ].mutableCopy;
    }
    return _people;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.adapter.collectionView=self.collectionView;
    self.adapter.dataSource=self;
}

// MARK: IGListAdapterDataSource
-(NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.people;
}

-(IGListSectionController<IGListSectionType> *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    StoryboardLabelSectionController *sectionController = [[StoryboardLabelSectionController alloc] init];
    sectionController.delegate = self;
    return sectionController;
}

-(UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    return nil;
}

-(void)removeSectionControllerWantsRemoved:(StoryboardLabelSectionController *)sectionController{
    NSInteger section = [self.adapter sectionForSectionController:sectionController];
    [self.people removeObjectAtIndex:section];
    [self.adapter performUpdatesAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
