String userId = '0052x0000057gF8AAI';
//Get Permission Set Assignment of the users
List<PermissionSetAssignment> assignmentList = [select id ,PermissionSetId ,PermissionSet.ProfileId ,PermissionSet.IsOwnedByProfile,PermissionSet.Profile.name  from PermissionSetAssignment  where AssigneeId =:userId];

Set<Id> permissionAssignmentIds = new Set<Id>();
for(PermissionSetAssignment pa : assignmentList){
    permissionAssignmentIds.add(pa.PermissionSetId);
}

System.debug('the ids '+permissionAssignmentIds);


// Get Object permissions from the available assignments
List<ObjectPermissions> objectPermissionList = [select id ,SobjectType, ParentId, Parent.ProfileId,Parent.Name,   Parent.Profile.Name,Parent.IsOwnedByProfile,  PermissionsRead, PermissionsCreate, PermissionsEdit, PermissionsDelete,PermissionsViewAllRecords, PermissionsModifyAllRecords  from ObjectPermissions where ParentId in :permissionAssignmentIds ];

System.debug('object size'+objectPermissionList.size());

// Get All Field access from permission sets and profiels
List<FieldPermissions> fieldPermissionList = [select id,SobjectType, Field,PermissionsRead, PermissionsEdit, Parent.IsOwnedByProfile,Parent.Profile.Name ,Parent.name  from FieldPermissions where ParentId In :permissionAssignmentIds ];
System.debug('field size'+fieldPermissionList.size());