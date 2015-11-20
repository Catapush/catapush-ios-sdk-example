//
//  ViewController.m
//  catapush-ios-sdk-example
//
//  Created by Chiarotto Alessandro on 11/11/15.
//  Copyright © 2015 Divisumma. All rights reserved.
//

#import "ViewController.h"
#import "MessageCell.h"
#import "CatapushHeaders.h"
#import "Constants.h"

static NSString *kCellIdentifier = @"CellConversationId";
static float CollectionInset = 5;


@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation ViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Messages"];
    [self.collectionView registerClass:[MessageCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self perfomFetch];
}

#pragma mark UICollectionView Delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger items = 0;
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        items = [sectionInfo numberOfObjects];
    }
    return items;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    MessageIP *message = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.text  = message.body;
    cell.textView.font = self.collectionView.messageTextFont;
    NSDate *previousDate = [self previousDate:message withIndexPath:indexPath];
    if(previousDate) {
        [cell setTimestamp:previousDate];
    }
    return cell;
}

-(NSDate *) previousDate:(MessageIP *) message withIndexPath:(NSIndexPath *) indexPath {
  if (indexPath.row > 0) {
    NSIndexPath *prevIndex = [NSIndexPath indexPathForRow:(indexPath.row - 1) inSection:indexPath.section];
    MessageIP *prevMsg = [self.fetchedResultsController objectAtIndexPath:prevIndex];
    NSTimeInterval timeGap = [message.sendTime timeIntervalSinceDate:prevMsg.sendTime];
    if(timeGap/60 > 5) {
        return message.sendTime;
    } else {
      return nil;
    }
  }
  return message.sendTime;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    MessageIP *message = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UITextView *textView = [UITextView new];
    textView.font = self.collectionView.messageTextFont;
    textView.text = message.body;
    float cellWidth = CGRectGetWidth(self.collectionView.frame) - CollectionInset*2;
    CGSize size = [textView sizeThatFits:CGSizeMake(cellWidth, CGFLOAT_MAX)];
    float cellHeight = ([self previousDate:message withIndexPath:indexPath] ? size.height+TimestampHeight:size.height);
    return CGSizeMake(cellWidth, cellHeight);
}

- (void)perfomFetch {
    self.fetchedResultsController.delegate = self;
    NSError *error;
    BOOL success = [self.fetchedResultsController performFetch:&error];
    if(success == false) {
      NSLog(@"performFetch failed!");
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      for (MessageIP *message in self.fetchedResultsController.fetchedObjects) {
          [self markMessageIPAsReadIfNeeded:message];
      }
      [self.collectionView reloadData];
    });
}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionView reloadData];
    for (MessageIP *message in self.fetchedResultsController.fetchedObjects) {
        [self markMessageIPAsReadIfNeeded:message];
    }
}

- (void)markMessageIPAsReadIfNeeded:(MessageIP *)messageIP{
    if (messageIP.status.integerValue == MessageIP_NOT_READ) {
        messageIP.status = [NSNumber numberWithInteger:MessageIP_READ];
        [MessageIP sendMessageReadNotification:messageIP];
        NSLog(@"sending reading notification for message with id: %@", messageIP.identifier);
    }
}

- (NSFetchedResultsController *)fetchedResultsController{
    if (!_fetchedResultsController) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MessageIP"];
        request.predicate = nil;
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"sendTime" ascending:YES]];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    }
    return _fetchedResultsController;
}


- (NSManagedObjectContext *)managedObjectContext{
    if (!_managedObjectContext) {
        _managedObjectContext = [CatapushCoreData managedObjectContext];
    }
    return _managedObjectContext;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
