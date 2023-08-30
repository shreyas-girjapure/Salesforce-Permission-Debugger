public without sharing class CommonSecurityController {
    
    /*
    List<String> x = new List<String>();
    x.add('0052x0000057gF8AAI');
    x.add('0052x000002fJUZAA2');
    CommonSecurityController.getAllPermissionAssignments(x);*/
    public static List<PermissionSetAssignment> getAllPermissionAssignments(List<String> userIds){
        List<PermissionSetAssignment> permissionAssignmentList = new List<PermissionSetAssignment>();
        try{
            permissionAssignmentList =  [select id ,PermissionSetId ,PermissionSet.ProfileId ,PermissionSet.IsOwnedByProfile,PermissionSet.Profile.name  from PermissionSetAssignment  where AssigneeId in:userIds];  
            System.debug(permissionAssignmentList);           
        }catch(Exception e){
            System.debug(e);
        }
        return permissionAssignmentList;
    }
}