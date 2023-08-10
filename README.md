# Salesforce-Permission-Debugger
Hello world !!, Instead of finishing old incomplete projects like a good boi. 
Here is ANOTHER new repository which I will now be committing to [at least for 2 days i hope 😑]. 
At this point I have no shame left anyway! Please go through Readme and Questions file to contribute. See you maybe on another repo 👋.

### Problem Statement OR Why this new repo ?
You are a very awesome developer , Creator and manager of lots and lots of awesome and super complex feature. 
Production involves lot of user specific issues.

For an instance ,

There comes a day when you are debugging where the user is getting permission from. 
1. is it from profile ?
1. is it from permission set 1 ?
1. is it from permission set 99 ? [world want reusable permission sets so not even exaggeration on number 99] ?
1. is it from owd / someone manually provided sharing access ?
1. is it MAGIC ? 
you wont know unless you waste your time checking all of the above.

Another instance could be , you want to know if user has access to some apex class or not ?
There are mostly 2 ways to find out 
1. Go to profile and check apex class's permission
1. Listen for debug logs and find your error there.

In Summary we want to know how a given user is getting record level access from ?
and what are user's security level accesses
