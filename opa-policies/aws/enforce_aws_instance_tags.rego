package terraform
 
import input as tfplan

deny[reason] {
  
    resource:= tfplan.resource_changes[_]
    resource.type =="aws_instance"
    not resource.change.after.tags.BU
  
    #trace("tags doesn't exist")
  reason := sprintf(
   "%s: resource type is missing BU required tags",
    [resource.type]
  )
  
}
deny[reason] {
  
    resource:= tfplan.resource_changes[_]
    resource.type =="aws_instance"
    not resource.change.after.tags.ENV
    #trace("tags doesn't exist")
  reason := sprintf(
   "%s: resource type is missing ENV required tags",
    [resource.type]
  )
  
}