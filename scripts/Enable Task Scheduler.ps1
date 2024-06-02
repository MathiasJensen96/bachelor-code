$ContainerName = ''

Invoke-ScriptInBCContainer -containerName $ContainerName -scriptblock {
         Set-NAVServerConfiguration -ServerInstance $ServerInstance -KeyName EnableUserConsistencyValidationOnTasks -KeyValue false
         Set-NAVServerConfiguration -ServerInstance $ServerInstance -KeyName EnableTaskScheduler -KeyValue true
}
 
Restart-NavContainer $ContainerName