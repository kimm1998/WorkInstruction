page 50550 "List Filters"
{
    Caption = 'List Filters';
    PageType = List;
    SourceTable = "List Filter";
    UsageCategory = Administration;
    ApplicationArea = All;
 
 
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Filter Code"; Rec."Filter Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Filter Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Table ID field.';
                }
                field("Table Name"; Rec."Table Name")
                {
                    ToolTip = 'Specifies the value of the Table Name field.', Comment = '%';
                }
                field("Filter"; Rec."Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Filter field.';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EditFilter;
                    end;
 
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
 
            action("Edit Filter")
            {
                Caption = 'Filter';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Filter;
                trigger OnAction()
                begin
                    EditFilter;
                end;
 
            }
        }
    }
 
    Local procedure EditFilter()
    var
        FilterPageBuilder: FilterPageBuilder;
        RequisitionLine: Record "Requisition Line";
    begin
        FilterPageBuilder.AddTable(rec."Table Name", rec."Table ID");
        FilterPageBuilder.PageCaption := rec."Table Name" + ' Filter';
        if rec.Filter <> '' then
            FilterPageBuilder.SetView(rec."Table Name", rec.Filter);
        if FilterPageBuilder.RunModal() then
            rec.Filter := FilterPageBuilder.GetView(rec."Table Name");
        rec.Modify(false);
    end;
 
}