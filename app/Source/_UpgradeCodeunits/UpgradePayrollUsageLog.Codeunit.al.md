codeunit 70472644 "UpgradeExample_EVAS" //TODO: Change name and rename file to .al
{
    Subtype = Upgrade;

    Permissions = tabledata... 

    internal procedure DoSomething()
    var
        UpgradeTag: Codeunit "Upgrade Tag";

    begin
        //Skip Upgrade if already executed
        if UpgradeTag.HasUpgradeTag(GetUpgradeTag()) then
            exit;

        //Handle data upgrade...

        //Mark Upgrade Tag as processed
        UpgradeTag.SetUpgradeTag(GetUpgradeTag());
    end;

    local procedure GetUpgradeTag(): Text
    var
        UpgradeTagLbl: Label '<Jira Key> <Description> <Version> <YYYY.MM.DD>', Locked = true;
    begin
        exit(UpgradeTagLbl);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", 'OnGetPerCompanyUpgradeTags', '', false, false)]
    local procedure OnGetPerCompanyUpgradeTags(var PerCompanyUpgradeTags: List of [Code[250]]);
    begin
        PerCompanyUpgradeTags.Add(GetUpgradeTag());
    end;
}