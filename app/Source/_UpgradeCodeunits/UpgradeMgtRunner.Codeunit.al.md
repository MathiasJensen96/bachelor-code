//Upgrade Caller Mgt.: Add call to each upgrade codeunit in your app. //TODO: Rename file to .al
codeunit 60001 "Upgrade Mgt. Runner_EVAS"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    begin
        UpgradeExample.DoSomething();
    end;
}