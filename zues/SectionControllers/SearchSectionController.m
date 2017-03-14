//
//  SearchSectionController.m
//  zues
//
//  Created by v on 17/2/14.
//  Copyright © 2017年 v. All rights reserved.
//
/**
 The examples provided by Facebook are for non-commercial testing and evaluation
 purposes only. Facebook reserves all rights not expressly granted.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#import "SearchSectionController.h"
#import "SearchCell.h"
@implementation SearchSectionController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDelegate = self;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake([self.collectionContext containerSize].width, 44);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    SearchCell *cell = [self.collectionContext dequeueReusableCellOfClass:[SearchCell class] forSectionController:self atIndex:index];
    if (cell) {
        cell.searchBar.delegate = self;
    }
    return cell;
}

- (void)didUpdateToObject:(id)object { }

- (void)didSelectItemAtIndex:(NSInteger)index { }

// MARK: UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.delegate searchSectionController:self didChangeText:searchText];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.delegate searchSectionController:self didChangeText:@""];
}

// MARK: IGListScrollDelegate
- (void)listAdapter:(IGListAdapter *)listAdapter didScrollSectionController:(IGListSectionController<IGListSectionType> *)sectionController {
    SearchCell *searchCell = [self.collectionContext cellForItemAtIndex:0 sectionController:self];
    if (searchCell) {
        searchCell.searchBar.text = @"";
        [searchCell.searchBar resignFirstResponder];
    }
}

- (void)listAdapter:(IGListAdapter *)listAdapter willBeginDraggingSectionController:(IGListSectionController<IGListSectionType> *)sectionController { }

- (void)listAdapter:(IGListAdapter *)listAdapter didEndDraggingSectionController:(IGListSectionController<IGListSectionType> *)sectionController willDecelerate:(BOOL)decelerate { }



@end
