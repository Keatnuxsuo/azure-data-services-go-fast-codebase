function(seed=0)
local tests =
[
    //****************************************************************//
    //*                    Execute Notebook Tests                    *//
    //****************************************************************//
    {        
        "Active": true,        
        "Pattern": "Execute-Notebook",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Notebook-Optional",
        "SourceType":"N/A",        
        "SourceDataFilename":"",
        "SourceSourceSystemAuthType": "MSI",
        "SourceSchemaFileName":"", 
        "SourceSkipLineCount":"",
        "SourceFirstRowAsHeader": "false",
        "SourceSheetName":"",
        "SourceMaxConcurrentConnections":0,
        "SourceRecursively":"false",
        "SourceDeleteAfterCompletion":"false",
        "SourceWriteSchemaToPurview": "Disabled",

        "TargetFormat":"Notebook-Optional",
        "TargetType":"N/A",        
        "TargetDataFilename":"",
        "TargetSchemaFileName":"",
        "TargetSourceSystemAuthType":"MSI", 
        "TargetSkipLineCount":"",
        "TargetFirstRowAsHeader": "false",
        "TargetSheetName":"",
        "TargetMaxConcurrentConnections":0,
        "TargetRecursively":"false",
        "TargetDeleteAfterCompletion":"false",
        "TargetWriteSchemaToPurview": "Disabled",

        "ExecuteNotebook": "Notebook 1",
        "CustomDefinitions": "",
        "Description": "Execute Notebook test - Please create a notebook in Synapse called Notebook1 to execute otherwise this wont work - the notebook can be blank.",  
        "SynapsePipeline": "GPL_SparkNotebookExecution_Primary_Azure",
        "Purview": "Disabled",
        "QualifiedIDAssociation": "TaskMasterId"   
       
    }

];

local template = import "./partials/functionapptest.libsonnet";

local process = function(index, t)
template(
    t.SynapsePipeline,
    t.Pattern, 
    seed-index,//t.TestNumber,
    t.SourceFormat,
    t.SourceType,
    t.SourceDataFilename,
    t.SourceSchemaFileName,
    t.SourceSourceSystemAuthType,
    t.SourceSkipLineCount,
    t.SourceFirstRowAsHeader,
    t.SourceSheetName,
    t.SourceMaxConcurrentConnections,
    t.SourceRecursively,
    t.SourceDeleteAfterCompletion,
    t.SourceWriteSchemaToPurview,
    t.TargetFormat,
    t.TargetType,
    t.TargetDataFilename,
    t.TargetSchemaFileName,
    t.TargetSourceSystemAuthType,
    t.TargetSkipLineCount,
    t.TargetFirstRowAsHeader,
    t.TargetSheetName,
    t.TargetMaxConcurrentConnections,
    t.TargetRecursively,
    t.TargetDeleteAfterCompletion,
    t.TargetWriteSchemaToPurview,
    t.Description,
    t.ExecuteNotebook,
    t.CustomDefinitions,
    t.Purview,
    t.QualifiedIDAssociation
);


std.mapWithIndex(process, tests)

