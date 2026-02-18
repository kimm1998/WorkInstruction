xmlport 50500 "Export Attribute Data"
{
    Caption = 'Export Product Data';
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
            tableelement(Headers; "Integer")
            {
                SourceTableView = where(Number = const(1));

                textelement(AttributeIDHdr) { }
                textelement(AttributeLabelEnHdr) { }
                textelement(AttributeLabelFrHdr) { }
            }
            tableelement(ItemAttributeValue; "Item Attribute Value")
            {
                RequestFilterFields = "Attribute ID";
                /*
                fieldelement(AttributeID; ItemAttributeValue."Attribute ID")
                {
                }
                */
                fieldelement(ID; ItemAttributeValue.ID)
                {
                }
                textelement(AttributeLabelEn) { }
                textelement(AttributeLabelFr) { }
                /*
                fieldelement(Value; ItemAttributeValue."Value")
                {
                }
                */
                trigger OnAfterGetRecord()
                var
                    ItemAttributeTranslation: Record "Item Attr. Value Translation";
                begin
                    Clear(AttributeLabelEn);
                    Clear(AttributeLabelFr);
                    ItemAttributeTranslation.SetRange("Attribute ID", ItemAttributeValue."Attribute ID");
                    ItemAttributeTranslation.SetRange("ID", ItemAttributeValue."ID");
                    ItemAttributeTranslation.SetRange("Language Code", 'ENC');
                    if ItemAttributeTranslation.FindFirst() then
                        AttributeLabelEn := ItemAttributeTranslation.Name;

                    ItemAttributeTranslation.SetRange("Language Code", 'FRC');
                    if ItemAttributeTranslation.FindFirst() then
                        AttributeLabelFr := ItemAttributeTranslation.Name;
                end;
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
        AttributeIDHdr := ItemAttributeValue.GetFilter("Attribute ID");
        ItemAttributeTranslation.SetFilter("Attribute ID", ItemAttributeValue.GetFilter("Attribute ID"));
        ItemAttributeTranslation.SetRange("Language Code", 'ENC');
        if ItemAttributeTranslation.FindFirst() then
            AttributeLabelEnHdr := ItemAttributeTranslation.Name;

        ItemAttributeTranslation.SetRange("Language Code", 'FRC');
        if ItemAttributeTranslation.FindFirst() then
            AttributeLabelFrHdr := ItemAttributeTranslation.Name;
    end;

    var
        ItemAttributeTranslation: Record "Item Attribute Translation";
}

