//Populate all Upgrade Tags //TODO: Rename file to .al
codeunit 60000 "Install Upgrade Tags_EVAS"
{
    Subtype = Install;

    trigger OnInstallAppPerDatabase();
    var
        UpgradeTag: Codeunit "Upgrade Tag";
    begin
        UpgradeTag.SetAllUpgradeTags();
    end;
}