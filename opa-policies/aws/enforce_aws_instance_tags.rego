AWS_instance_tags_BU_exist[reason] {
  
    resource:= tfplan.resource_changes[_]
    resource.type =="aws_instance"
    not resource.change.after.tags.BU
  
    #trace("tags doesn't exist")
  reason := sprintf(
   "%s: resource type is missing the required tags",
    [resource.type]
  )
  
}
AWS_instance_tags_ENV_exist[reason] {
  
    resource:= tfplan.resource_changes[_]
    resource.type =="aws_instance"
    not resource.change.after.tags.ENV
    #trace("tags doesn't exist")
  reason := sprintf(
   "%s: resource type is missing the required tags",
    [resource.type]
  )
  
}