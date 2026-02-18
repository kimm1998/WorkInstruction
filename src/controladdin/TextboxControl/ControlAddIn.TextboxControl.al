controladdin "Textbox Control"
{
    Scripts =
                'Scripts/textboxControl.js',
                'https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js';
    StyleSheets =
                'Styles/textboxControl.css';
    StartupScript =
                'Scripts/textboxControlStartup.js';

    RequestedHeight = 100;
    MinimumHeight = 50;
    MinimumWidth = 200;
    MaximumHeight = 500;
    VerticalStretch = true;
    HorizontalStretch = true;


    procedure refocusInput(x: integer);

    event OnInitialized();
    event OnFocusOut(Value: Text)
}