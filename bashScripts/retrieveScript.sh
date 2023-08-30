# full command
sfdx project retrieve start --target-metadata-dir outputPackage  --manifest manifest/package.xml
# Aliased version with org's alias
sfdx retrieve:metadata -t outputDir -x manifest/package.xml -o mainDevOrg