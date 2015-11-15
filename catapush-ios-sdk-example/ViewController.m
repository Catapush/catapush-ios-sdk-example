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

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController; //handles all Messages
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;



@end

@implementation ViewController {

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    MessageIP *message = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.text  = message.body;

    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageIP *message = [self.fetchedResultsController objectAtIndexPath:indexPath];
    CGRect textRect = [message.body boundingRectWithSize:CGSizeMake(self.collectionView.frame.size.width-TEXT_PADDING*2,0)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName: FONT }
                                                 context:nil];
    
    return CGSizeMake(self.collectionView.frame.size.width - TEXT_PADDING * 2,
                      ceil(textRect.size.height + TEXT_PADDING * 2));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(TEXT_PADDING, 0, TEXT_PADDING, 0);
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
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
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
