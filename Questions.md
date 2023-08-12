## Questions ?

1. How to get user's all permissions ?
1. How to know if a field has permission in the given permission set / profile ?
1. How to query for owds ?
1. How get share record instances of the user per object ?


1. How to query object's Related info ?
There exists a `EntityDefinition` object which provides basic details and its related objects.
Related objects have meaningful entries like `UserEntityAccess`,`UserFieldAccess`,`FieldDefinition`,`CustomFieldDefinition`,`ApexTrigger`,`	NamedFilter`

Generally Object is said to be `entity` in tooling api's terms. So limits and other related stuff is stored in entity named objects.

`entityparticle` does not provide much informative info for deeper level implementions , can be ignored and instead use `fiedDefinition`

1. How to get field level info ?
`FieldDefinition` object provides info related to field and its metadata . Has few important relationships like `UserEntityAccess` , `EntityDefinition`

1. Shreyas user id `0052x000002fJUZAA2`
1. testBoi user id `0052x0000057g0rAAA`

1. `UserEntityAccess` ?
It is still not known how this object provides values , object and userid's combination should return access defined. but results are very inconsistent. Not useful for projet's work

1. `ObjectPermission`
Helps providing profile and permission set level access for the objects , use `parent.profile.Name` to get profile info

1. Refs
http://www.gavan.in/2021/09/sharing-access-to-profile-or-permission.html
