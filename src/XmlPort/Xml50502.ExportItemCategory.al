xmlport 50502 "Export Item Category"
{
    Caption = 'Export Item Category';
    Direction = Export;
    Format = VariableText;
    FieldDelimiter = '"';
    FieldSeparator = ';';
    TableSeparator = '<NewLine>';
    TextEncoding = UTF8;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(XMLHeaders; "Integer")
            {
                SourceTableView = where(Number = const(1));
                textelement(FileHdrENC) { }
                textelement(FileHdrFRC) { }
            }
            tableelement(ItemCategory; "Item Category")
            {
                fieldelement(Code; ItemCategory."Code")
                {
                }
                fieldelement(Description; ItemCategory.Description)
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort();
    begin
        FileHdrENC := HeaderLbl;
        FileHdrFRC := HeaderFRCLbl;
    end;

    var
        HeaderLbl: Label 'Category code';
        HeaderFRCLbl: Label 'Categorie';
}

