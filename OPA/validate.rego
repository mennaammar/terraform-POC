package terraform
 
import input as tfplan

 
array_contains(arr, elem) {
	arr[_] = elem
}
 

AWS_instance_tags_exist[reason] {
  
    resource:= tfplan.resource_changes[_]
    resource.type =="aws_instance"
    not resource.change.after.tags.BU
    not resource.change.after.tags.ENV
    #trace("tags doesn't exist")
  reason := sprintf(
   "%s: resource type is missing the required tags",
    [resource.type]
  )



  
}

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
S3_validate_not_public[reason_public] {
  
    resource:= tfplan.resource_changes[_]
    resource.type =="aws_s3_bucket"
    #trace(resource.change.after.acl)
    resource.change.after.acl != "private"

  reason_public := sprintf(
   "%s: resource type is missing acl",
    [resource.type]
  )
}


S3_validate_not_encrypted[reason] {
  
    resource:= tfplan.resource_changes[_]
    resource.type =="aws_s3_bucket"
    
   not resource.change.after.server_side_encryption_configuration[0].rule

  reason := sprintf(
   "%s: resource type is missing encryption",
    [resource.type]
  )
}

