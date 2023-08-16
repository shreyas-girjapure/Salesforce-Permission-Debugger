## Questions ?

1. How to get user's all permissions ?
1. How to know if a field has permission in the given permission set / profile ?
1. How to query for owds ?
    1. InternalSharingModel is for internal salesforce users.
    1. `select id ,DeveloperName, ExternalSharingModel, InternalSharingModel from EntityDefinition` 
     
1. How get share record instances of the user per object ?

1. How to query object Related info ?

    There exists a `EntityDefinition` object which provides basic details and its related objects.

    Related objects have meaningful entries like `UserEntityAccess`,`UserFieldAccess`,`FieldDefinition`,`CustomFieldDefinition`,`ApexTrigger`,`	NamedFilter`

    Generally Object is said to be `entity` in tooling api's terms. So limits and other related stuff is stored in entity named objects.

    `entityparticle` does not provide much informative info for deeper level implementations , can be ignored and instead use `fiedDefinition`

1. How to get field level info ?

    `FieldDefinition` object provides info related to field and its metadata . Has few important relationships like `UserEntityAccess` , `EntityDefinition`

1. Test Data
> 
        1. Shreyas user id `0052x000002fJUZAA2`
        1. testBoi4 user id `0052x0000057gF8AAI`
        1. AccessCheckRecord id1 `a032x00000S7Zf4AAF`
        1. AccessCheckRecord id2 `a032x00000S7ZfEAAV`

        1. permissionIds `0PS2x000001bM3VGAU`
        1. permissionIds `0PS2x000001bM3aGAE`
        1. profile id `00e2x000000q8cFAAQ`

        1. Durable id for name => AccessCheck `01I2x000000KmQg.Name`
        1. Durable id for rev => Account `Account.AnnualRevenue`
  

1. Get all objects of an org
    
    Use this in tooling api mode to get all the objects
 
    `select id ,QualifiedApiName from EntityDefinition`

    Or 
    
    Get all objects from describe schema

1. Get all fields of objects 
    
    Use this in tooling api mode to get all the fields
    
    `select id ,DataType, DeveloperName, DurableId, EntityDefinition.QualifiedApiName,  ReferenceTo, RelationshipName from FieldDefinition where EntityDefinition.QualifiedApiName In ('AccessCheck__c','Account')`
    
    Or 
    
    Get all fields from describe schema


1. Get all permissions and Profile for a user

    `PermissionSetAssignment`
    Helps identifying user and permission set relation , also provides profile info

    `select id ,PermissionSetId ,PermissionSet.ProfileId ,PermissionSet.IsOwnedByProfile,PermissionSet.Profile.name  from PermissionSetAssignment  where AssigneeId = '0052x0000057gF8AAI'`  

1. Get all object permissions for permSets and Profile

    `ObjectPermissions` Helps providing profile and permission set level access for the objects , use `parent.profile.Name` to get profile info

    `select id ,SobjectType, ParentId, Parent.ProfileId,Parent.Name,  Parent.Profile.Name,Parent.IsOwnedByProfile,  PermissionsRead, PermissionsCreate, PermissionsEdit, PermissionsDelete from ObjectPermissions where ParentId in ('0PS2x000001bM3VGAU','0PS2x000001bM3aGAE')`

1. Get all fieldPermissions for permSets and profile
    
    This provides only entries which are mapped to permSet or profile. Not all entries are there. Example if field is not provided access. It wont even display in query rows.

    `select id,SobjectType, Field,PermissionsRead, PermissionsEdit, Parent.IsOwnedByProfile,Parent.Profile.Name ,Parent.name  from FieldPermissions where ParentId In ('0PS2x000001bM3VGAU','0PS2x000001bM3aGAE')`


1. `UserEntityAccess` ?

    This has row limits

    `select id ,User.Username,  EntityDefinition.QualifiedApiName, IsReadable, IsEditable, IsDeletable, IsUpdatable, from UserEntityAccess where UserId  = '0052x0000057gF8AAI' limit 2000`

1. `UserFieldAccess` ?
    
    Enforces durable ids to be involved durable id need to have userid at the end. Which is inefficient .

1. `UserRecordAccess` ?

    For given user and record id it can let us know following access available.   
    `select  RecordId  , HasAllAccess, HasDeleteAccess, HasEditAccess, HasReadAccess,HasTransferAccess,MaxAccessLevel   from UserRecordAccess where RecordId IN ( 'a032x00000S7Zf4AAF','a032x00000S7ZfEAAV') and UserId = '0052x000002fJUZAA2' `

1. Why not use `Schema` to get accessibility and other level of accesses ?

    `Schema` definitions are only provided in content of running user. Though its a foul proof way of providing permission and access related information. This implementation focuses on ability to provide any user as an input.

1. References

    1. http://www.gavan.in/2021/09/sharing-access-to-profile-or-permission.html
    1. [Tooling Api Sobjects](https://developer.salesforce.com/docs/atlas.en-us.api_tooling.meta/api_tooling/reference_objects_list.htm)
    1. [Dependency Tree Similar implementation](https://appexchange.salesforce.com/appxListingDetail?listingId=a0N3A00000FeF99UAF)
    1. [Permatrix Similar implementation ](https://appexchange.salesforce.com/appxListingDetail?listingId=a0N4V00000HJDp4UAH&tab=d)
    1. [Tooling API from apex](https://medium.com/dyno-dev/calling-tooling-api-from-apex-1913933284da)
    1. [Tooling API from LWC](https://salesforcecodex.com/salesforce/call-tooling-api-from-lightning-web-component/)
    1. [Row Access Architecture](https://developer.salesforce.com/docs/atlas.en-us.salesforce_record_access_under_the_hood.meta/salesforce_record_access_under_the_hood/uth_entity.htm)


1. OWD and Object Setting table 

    | OWD | Profile | Outcome |
    |----|---|---|
    |Private |Read |User can only read their records.|
    |Private | Create, Read |	User can create record, but they can read only their records.|
    |Private	|Create, Read, Edit|	User can create record, but they can read and edit their records only.|
    |Public read|	Read	|User can read all records as OWD being public read. But they will not have edit access to the object and internally to all records.|
    |Public read	|Create, Read	|User can create records and he can read all records as OWD being public read. But they will not have edit access to the object and internally to all records.|
    |Public read|	Create, Read, Edit	|User can create, read all records but they can edit only their records.|
    |Public read/ write	|Read	|User can read all records as OWD being public read/write. But they will not have edit access to the object and internally to all records.|
    |Public read/ write	|Create, Read	|User can create records and read all records as OWD being public read/write. But they will not have edit access to the object and internally to all records.|
    |Public read/ write	|Create, Read, Edit	|User can create, read and write anyone's record.
