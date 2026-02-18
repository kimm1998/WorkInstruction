codeunit 50525 "Blob Storage Mgt"
{
    trigger OnRun()
    var
        TempBlob: Codeunit "Temp Blob";
        ExportProductData: XmlPort "Export Product Data";
        ProductOutStream: OutStream;
        ProductInStream: InStream;
        FileNameLbl: Label 'Products_%1.csv';
        FileDate: Text[250];
    begin
        SalesSetup.Get();
        TempBlob.CreateOutStream(ProductOutStream);
        ExportProductData.SetDestination(ProductOutStream);
        ExportProductData.Export();
        TempBlob.CREATEINSTREAM(ProductInStream);
        FileDate := format(DT2Time(CurrentDateTime));
        if StrPos(FileDate, ' ') <> 0 then
            FileDate := DelChr(FileDate, '=', ' ');
        if StrPos(FileDate, ':') <> 0 then
            FileDate := DelChr(FileDate, '=', ':');
        UploadfileintoContainers(ProductInStream, StrSubstNo(FileNameLbl, format(Date2DMY(WorkDate(), 3)) + format(Date2DMY(WorkDate(), 2)) + format(Date2DMY(WorkDate(), 1)) + '_' + FileDate), SalesSetup."Product Folder Location");

    end;

    // This one import the file into Azure blob storage container
    procedure UploadfileintoContainers(instr: InStream; filename: Text; AccountContainer: Text)
    var
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        ABSBlobClient: Codeunit "ABS Blob Client";
        ABSOperationResponse: Codeunit "ABS Operation Response";
        Authorization: Interface "Storage Service Authorization";
        AccountAccessKey: Text;
        AccountName: Text;
    begin
        SalesSetup.Get();
        SalesSetup.TestField("Azure Account Key");
        SalesSetup.TestField("Azure Account Name");
        SalesSetup.TestField("Product Folder Location");
        SalesSetup.TestField("Attribute Folder Location");
        AccountAccessKey := SalesSetup."Azure Account Key";
        AccountName := SalesSetup."Azure Account Name";
        AccountContainer := AccountContainer;
        Authorization := StorageServiceAuthorization.CreateSharedKey(AccountAccessKey);
        ABSBlobClient.Initialize(AccountName, AccountContainer, Authorization);
        ABSOperationResponse := ABSBlobClient.PutBlobBlockBlobStream(filename, instr);
        if not ABSOperationResponse.IsSuccessful() then
            Error(ABSOperationResponse.GetError());
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
}