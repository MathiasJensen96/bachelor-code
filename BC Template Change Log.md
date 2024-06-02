# Business Central Template Change Log

## Version 1.23 ##
* /azure-pipelines.yml: added support for runtime packages

## Version 1.22 ##
* /azure-pipelines.yml: added support for build completion on the correct branch.

## Version 1.21 ##
* /azure-pipelines.yml: support for .bclicense format and correct auto selection of License File based on major BC version. Step for printing variables also moved.

## Version 1.20 ##
* /azure-pipelines.yml: hotfix for Xliff generation and more use of Yaml Templates for creating containers.
* /Images/EV_Logo.png: new rebranded logo added.

## Version 1.19 ##
* /azure-pipelines.yml: major redesign for supporting dependencies from Azure Blob Storage and management via EVCompilterSettings.json
* Added /app/OnPremExampleWithContiniaEVCompilerSettings.json.md
* Updated /README.MD with to-do instructions for utilizing Azure Blob Storage for your dependencies instead of having these in the repo

## Version 1.18 ##
* /azure-pipelines.yml: enabled PerTenantExtensionCop, removed Hyper-v isolation in ALOpsDockerStart, new step (ALOps hotfix) to create folder in Docker between ALOpsDockerStart and ALOpsDockerWait, ALOpsDockerWait: timout increased to 12 minutes
* /app/BC*_app.json changed logo path syntax from \\ to /
* /app/.vscode/settings.json and /test/.vscode/settings.json added semantic highlighting and enabled PerTenantExtensionCop

## Version 1.17 ##
* /azure-pipelines.yml: Disabled Task Scheduler, Installation of 'Permissions Mock' with Test Toolkit, Changed row of order in steps, Sign of Test App, Use Latest License File available if neither BC_Version nor BC_License variables are specified, Next minor/major hotfixm Custom diagnostics replaced with AlOps step, Add cleanup
* Modernization of template app.json for latest BC version incl. Cloud as default target
* Added "Object ID Ninja" as recommendation in /App/.vscode/extensions.json 
* Deleted file /Test/.vscode/extensions.json 
* Added example files for handling data upgrade using Upgrade Tag - folder: /App/_UpgradeCodeunits
* Removed "coenraads.bracket-pair-colorizer-2" from extension recommendations
* /app/settings.json: AppSourceCop added as code analyzer 
* Cleanup in /app/custom.ruleset.json and /test/custom.ruleset.json incl. todo actions
* Hotfix for Git Settings in /BC Template.code-workspace and also added Container settings for utilizing "EV: Create Container from settings" command
* ./gitattributes updates with Git LFS support for *.app, *.dll, *.zip files. Git client on developer PC and Azure Build Pipelines (Checkout with LFS) must be updated!

## Version 1.16 ##
* Added folder /app/AppSourceCop
* Added file /app/AppSourceCop.json
* Updated /Azure-pipelines.yml with new default values (to ease the setup in DevOps) and support for multiple BC Versions in the same repo
* Updated /.vscode/extensions.json to no longer include Waldo's AL Extension Package but instead only specific extensions
* Added additional to-do markings for both target, objects and AppSourceCop incl. breaking changes detection. Object default range changed to 6xxxx to avoid conflicts in BC Online
* Added .snapshots folder for all levels to /.gitignore
* /app/.vscode/settings.json: To-do marking regarding analyzers and exclusion of "system directories" in VS Code: "Search in Files"

## Version 1.15 ##
* Never released

## Version 1.14 ##
* Renamed app/Dependencies/Readme.txt  and app/CustomerOnlyApps/Readme.txt -> Readme.md due to restrictions in the AL Compiler
* Multiple fixes and enhancements to /test
* Added test/.vscode/launch.json to /.gitignore
* Added AA0072, AA0210 and AA0232 and sorted the file /app/custom.ruleset.json
* Updated links in /README.md
* Added folder /PrevAppVersion - see readme.md file in folder for instructions
* /azure-pipelines.yml: testpage added to ALOpsAppTest + Using Azure KeyVault for ALOps & BC Licenses. BC Environment must be configured via Pipeline variables in the Web Interface and no longer in code. Failing Unit Test will now break the build.

## Version 1.13 ##
* BC16 app.json example files added to app, debug and test
* Updated /azure-pipelines.yml to use "BC Artifacts" (ALOpsDockerCreate + ALOpsDockerStart re-designed). Optional PublishBuildArtifacts added and Inline Documentation updated.
* Added folder /app/CustomerOnlyApps and file /app/CustomerOnlyApps/Readme.txt with instructions on which apps to place /app/CustomerOnlyApps/
* Added file /app/Dependencies/Readme.txt with instructions on which apps to place /app/Dependencies/

## Version 1.12 ##
* Forced the use of Microsoft AL Formatter in /App/settings.json
* Removed "rasmus.al-formatter" as VS Code Extension recommendation in /App/.vscode/extension.json
* Added additional temporary folders generated by either the compiler or most common VS Code Extensions to ./gitignore
* Added Debug folder to the Workspace to enable possibility to easily do remote debugging. Folders/files in /Debug/ added to .gitignore.
* Rename folder /Test -> /test to align with app and debug folder casing

## Version 1.11 ##
* Implemented ALOps License Key handling in /azure-pipelines.yml
* Added "CRS.RemoveUnderscoreFromFilename" parameter to /App/.vscode/settings.json to ensure that underscores are always removed in filenames.
* Updated /.gitignore to ensure that new .altestrunner folders are not tracked in git 

## Version 1.10 ##
* Fixed incorrect Git LF handling in: /.gitignore and /App/Cside/Install.json
* Added ToDo for renaming Workspace file
* Added Custom RuleSet file incl. reference for this in /App/settings.json
* Removed Windows.Title setting in /App/settings.json as this is covered by renaming the workspace file
* Renamed /Test/app.json -> BC15_app.json and added content to the file
* Small updates to /App/BC15_app.json
* Changed Jira link in /README.md
* Added app/.vscode/.alcache/*.* and Test/.vscode/.alcache/*.* to ./gitignore

## Version 1.09 ##
* Enabled UICop and AL Code Analysis
* Disabled Git Smart Commit - to force staging of changed files
* Workspace file: Renamed Extension -> App
* Object Type related folders under App/Source/ deleted
* Added _Module_Name and ExtensionObjects under App/Source/
* Multiple updates to YAML Build Pipeline definition

## Version 1.08 ##
* Removed all sub folders from app/Source/<Object Type> except for codeunits
* Added multiroot workspace file: /AL.code-workspace
* Removed old script files
* Replaced extention recommendations: clipdynamics.al-language-tools -> elbekvejrup.ev-business-central-dev-tool in app/.vscodee/extensions.json
* Deleted /repo_settings.json as these settings will be handled in /azure-pipelines.yml and in the Azure DevOps Release Pipeline
* Added build pipeline instructions in /azure-pipelines.yml
* Fixed partial UTF-16 encoding bug in app/settings.json
* Deleted app/Test folder
* Added script to active Task Scheduler service: /scripts/Enable Task Scheduler.ps1
* Extended al.assemblyProbingPaths with expected upcoming installation folder: "Microsoft Dynamics 365 Business Central"
* Disable ev-tools.autostart-container in workspace settings

## Version 1.07 ##
* Renamed /Dependencies/.gitkeep -> /Dependencies/.gitignore to ensure that Apps are kept in the Repo
* /.gitattributes: fixed binary typo error for handling jpg files

## Version 1.06 ##
* Added /.gitattributes to ensure identical handling of line feeds in "text files" across pc's

## Version 1.05 ##
* New EV App Logo

## Version 1.04 ##
* Deleted file /app/Fonts/.gitkeep as fonts already exits in this folder and this file shows an error during font installation
* Deleted file /app/.vscode/launch.json as it will be auto-generated when the Docker Container is created
* .gitignore exception on *.app files added to: /app/Dependencies/.gitignore
* Added app/.vscode/launch.json to .gitignore
* Added "window.title" to workspace setttings file: /app/.vscode/settings.json to make it possible to show project name as a part of the VS Code title (show where you are working)
* Renamed /app/app.json to /app/BC14_app.json
* Added /app/BC15_app.json
* Totally redesigned /repo_settings.json with new CI pipeline settings
* Updated instructions in /README.md file

## Version 1.03 ##
* Hotfix due to an update in EVBusinessCentralDevelopmentHelper module and auto execution of Update-Launch function.

## Version 1.02 ##
* Added folders .altemplates and .alcache to .gitignore

## Version 1.01 ##
* Added file 'BC Template Change Log.md'
* Subfolder structure from App/Source/Pages copied to App/Source/PageExtensions
* App/Source/Tables/TempClasses renamed to Buffers
* Subfolder structure from App/Source/Tables copied to App/Source/TableExtensions
* Folder App/WebServices deleted
* Folder App/Source/Codeunits/Upgrade renamed to Install-Upgrade
* Folders App/Source/Codeunits/Classes and Methods combined into Classes-Methods
* Added folder App/Fonts incl. default font as prep. for future auto import
* Added folder App/CSide to handle automatic import of fob and text files
* Added file App/CSide/Install.json to define which objects to import and if all Objects should be compiled
* Added file App/CSide/HowToUse text file with example on how to use this feature
* Removed the word 'Test' from all .gitkeep files

## Version 1.00 ##
* Initial release