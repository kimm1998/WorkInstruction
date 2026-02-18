codeunit 50524 "Single Instance"
{
    SingleInstance = true;

    procedure SetByFamily(_ByFamily: Boolean)
    begin
        ByFamily := _ByFamily;
    end;

    procedure GetByFamily(): Boolean
    begin
        exit(ByFamily);
    end;

    procedure SetTargetStatus(_Status: Enum "Production Order Status")
    begin
        Status := _Status;
    end;

    procedure GetTargetStatus(): Enum "Production Order Status"
    begin
        exit(Status);
    end;

    procedure SetLicensePlates(LicensePlateNo: code[20])
    var
    begin
        if not LicensPlateNos.Contains(LicensePlateNo) then
            LicensPlateNos.Add(LicensePlateNo);
    end;

    procedure GetLicensePlateNos(): list of [code[20]]
    var
    begin
        exit(LicensPlateNos);
    end;

    procedure SetItemNo(ItemNoPar: code[20])
    var
    begin
        ItemNo := itemnoPar;
    end;

    procedure GetItemNo(): code[20]
    var
    begin
        exit(ItemNo);
    end;

    var
        ByFamily: Boolean;
        Status: Enum "Production Order Status";
        LicensPlateNos: list of [code[20]];
        ItemNo: code[20];
}