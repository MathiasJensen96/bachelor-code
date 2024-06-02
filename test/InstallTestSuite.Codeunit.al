//#TODO: This file is only an example on how to install a Test Suite
codeunit 50100 "Install Test Suite_EVAS"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        SetupTestSuite();
    end;

    procedure SetupTestSuite()
    var
        ALTestSuite: Record "AL Test Suite";
        TestSuiteMgt: Codeunit "Test Suite Mgt.";
        SuiteName: Code[10];
    begin
        SuiteName := 'EV-TEST'; //#TODO: Must match the setup in your /azure-pipelines.yml file
        
        if ALTestSuite.Get(SuiteName) then
            ALTestSuite.Delete(true);

        TestSuiteMgt.CreateTestSuite(SuiteName);
        Commit();
        ALTestSuite.Get(SuiteName);
        ALTestSuite.Description := copystr('Test Suite for EV Customizations',1,maxstrlen(ALTestSuite.Description));
        ALTestSuite.Modify();

        TestSuiteMgt.SelectTestMethodsByRange(ALTestSuite, '50000'); //#TODO: Must be aligned with the Objects used for Unit Tests
    end;
}